import AVFoundation
import Foundation
import UIKit

public protocol ResultState {
    
    var isOk: Bool { get }
    
    var description: String { get }
}

struct BaseControllerConfiguration {
    
    enum ProcessType {
        case document
        case face
        case selfie
    }

    static let DEFAULT_VIDEO_RESOLUTION = 1920
    
    static let DEFAULT_VIDEO_FPS = 30 // FPS not used for now

    static let `default` = BaseControllerConfiguration(showVisualisation: true, 
                                                       showHelperVisualisation: true,
                                                       dataType: .picture,
                                                       cameraType: .back,
                                                       requestedResolution: Self.DEFAULT_VIDEO_RESOLUTION,
                                                       requestedFPS: Self.DEFAULT_VIDEO_FPS,
                                                       processType: .document)

    public let showVisualisation: Bool
    
    public let showHelperVisualisation: Bool
    
    public let showTextInstructions: Bool
    
    public let dataType: DataType
    
    public let cameraType: CameraType
    
    public let requestedResolution: Int
    
    public let requestedFPS: Int
    
    public let processType: ProcessType

    init(
        showVisualisation: Bool,
        showHelperVisualisation: Bool,
        showTextInstructions: Bool = true,
        dataType: DataType,
        cameraType: CameraType,
        requestedResolution: Int,
        requestedFPS: Int,
        processType: ProcessType
    ) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showTextInstructions = showTextInstructions
        self.dataType = dataType
        self.cameraType = cameraType
        self.processType = processType

        // 0 - not configured on BE
        if requestedFPS == 0 {
            self.requestedFPS = Self.DEFAULT_VIDEO_FPS
        } else {
            self.requestedFPS = requestedFPS
        }

        // 0 - not configured on BE
        if requestedResolution == 0 {
            self.requestedResolution = Self.DEFAULT_VIDEO_RESOLUTION
        } else {
            self.requestedResolution = requestedResolution
        }
    }
}

public class BaseController<ResultType: ResultState> {
    
    var temp: String = ""
        
    public var camera: Camera
    
    public weak var view: CameraView?

    var videoWriter: VideoWriter?

    /// Area with reticle.
    var targetFrame: CGRect { view?.overlay?.targetFrame ?? .zero }
    
    var previewFrame: CGRect = .zero
    
    var isRunning: Bool = false

    var previousResult: ResultType?
        
    var latestSuccessfullBuffer: CVPixelBuffer?

    /// Overlay image name (e.g. reticle image).
    var overlayImageName: String { "targettingRect" }

    private(set) var baseConfig: BaseControllerConfiguration = .default
    
    /// Whenever visualisation is visible or nor.
    private var isVisualisationAllowed: Bool { baseConfig.showVisualisation }
    
    /// Produce `true` if current process is Hologram check.
    private var shouldBeTorchEnabled: Bool {
        baseConfig.processType == .document && baseConfig.dataType == .video
    }
    
    /// Static overlay is document reticle.
    var canShowStaticOverlay: Bool {
        canShowVisualisation() && isVisualisationAllowed
    }
    
    /// Instruction view is text in the middle of reticle.
    var canShowInstructionView: Bool {
        baseConfig.dataType != .video && canShowStaticOverlay
    }

    init(camera: Camera, view: CameraView) {
        self.camera = camera
        self.view = view
    }

    deinit {
        videoWriter?.stop()
    }

    func configure(configuration: BaseControllerConfiguration = .default) throws {
        camera.delegate = self
        baseConfig = configuration
        isRunning = false
        view?.layoutIfNeeded()

        try? camera.configure(with: .init(type: configuration.cameraType))        
        
        view?.previewLayer = camera.previewLayer
        view?.setup()

        let overlayView = CameraOverlayView(imageName: overlayImageName)
        view?.configureOverlay(overlayView, isStatic: canShowStaticOverlay)

        if baseConfig.dataType == .video {
            videoWriter = VideoWriter()
            videoWriter?.delegate = self

            // start camera for face liveness and don't defer the start of the video after the ID was aligned (SZENID-2123)
            if baseConfig.processType == .face {
                startVideoWriter()
            }
        }

        view?.showInstructionView = canShowInstructionView
        
        view?.onLayoutChange = { [weak self] in
            self?.onLayoutChange()
        }

        previousResult = nil
        start()
        isRunning = true
    }

    public func start() {
        camera.start()
    }

    public func stop() {
        camera.stop()
        videoWriter?.delegate = nil
        videoWriter?.stop()
        videoWriter = nil        
    }

    func verify(pixelBuffer: CVPixelBuffer) -> ResultType? { nil }

    func getRenderCommands(size: CGSize) -> String? { nil }

    func callDelegate(with result: ResultType) { }

    func callDelegate(with videoUrl: URL) { }

    func callUpdateDelegate(with result: ResultType) { }

    /// Called after layout did change.
    func onLayoutChange() {
        /*DispatchQueue.main.async { [weak self] in
            self?.previewFrame = self?.view?.overlay?.bounds ?? .zero
        } */
        previewFrame = view?.overlay?.bounds ?? .zero
        
        camera.setOrientation()
        
        restartVideoWriter()
        
        camera.setTorch(on: shouldBeTorchEnabled)
    }
    
    /// Restart video recording.
    func restartVideoWriter() {
        guard let videoWriter, videoWriter.isRecording else { return }
        
        videoWriter.stopAndCancel()
        DispatchQueue.main.async { [weak self] in
            self?.startVideoWriter()
        }
    }

    private func startVideoWriter() {
        videoWriter?.start(isPortrait: UIInterfaceOrientation.current.isPortrait,
                           requestedWidth: baseConfig.requestedResolution,
                           requestedFPS: baseConfig.requestedFPS)
    }
}

extension BaseController {
    
    // Reticle frame position.
    func getOverlayTargetFrame() -> CGRect {
        let size = camera.getCurrentResolution()
        let imageRect = CGRect(origin: .zero, size: size)
        return targetFrame.rectThatFitsRect(imageRect)
    }

    
    /// Crop image data from buffer.
    ///
    /// It is used that verifier is checking only cropped data and not whole camera stream.
    ///
    /// - Parameter pixelBuffer: Input pixel buffer.
    /// - Returns: Cropped pixel buffer.
    func getCroppedPixelBuffer(pixelBuffer: CVPixelBuffer) -> CVPixelBuffer? {
        // camera frame size
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)

        // find cropping
        let cropRect = getCroppedImageRect(width: width, height: height)

        // create (cropped) image
        let image = UIImage(pixelBuffer: pixelBuffer, crop: cropRect)
        return image?.toCVPixelBuffer()
    }

    
    /// Calculate rectangle for crop.
    ///
    /// - Parameters:
    ///   - width: Source width.
    ///   - height: Source height.
    /// - Returns: Calculated rectangle.
    func getCroppedImageRect(width: Int, height: Int) -> CGRect {
        #if targetEnvironment(simulator)
        return CGRect(x: 0, y: 0, width: width, height: height)
        
        #else
        switch Defaults.videoGravity {
        case .resizeAspect:
            // With resize aspect we always process whole image.
            return CGRect(x: 0, y: 0, width: width, height: height)
        case .resizeAspectFill:
            // With aspect fill we crop from inside of the image frame
            let imageRect = CGRect(x: 0, y: 0, width: width, height: height)
            let layerRect = previewFrame.rectThatFitsRect(imageRect)
            return layerRect
        default:
            return .zero
        }
        
        #endif
    }

    func renderCommands(commands: String, imageRect: CGRect, pixelBuffer: CVPixelBuffer) {
        guard
            baseConfig.showHelperVisualisation,
            previewFrame != .zero
        else { return }
        
        if let drawLayer = view?.drawLayer {
            drawLayer.frame = imageRect
            let renderables = RenderableFactory
                .createRenderables(commands: commands,
                                   showTextInstructions: baseConfig.showTextInstructions)
            drawLayer.setRenderables(renderables)
        }
    }

    func updateView(with result: ResultType?, buffer: CVPixelBuffer) {
        guard let result else {
            view?.statusButton.setTitle("nil result", for: .normal)
            return
        }
        guard result.isOk, !(previousResult?.isOk ?? false) else {
            view?.statusButton.setTitle(String(describing: result.description), for: .normal)
            return
        }
        previousResult = result

        guard isRunning else { return }
        isRunning = false

        if baseConfig.dataType == .video {
            videoWriter?.stop()
            return
        }
        callDelegate(with: result)
    }

    func canShowVisualisation() -> Bool {
        view?.webViewOverlay == nil
    }
}

extension BaseController: VideoWriterDelegate {
    
    public func didTakeVideo(_ videoAsset: AVURLAsset) {
        callDelegate(with: videoAsset.url)
    }
}

extension BaseController: CameraDelegate {
    
    func cameraDelegate(camera: Camera, onOutput sampleBuffer: CMSampleBuffer) {
        guard isRunning else { return }
        guard previewFrame.width > 0 else { return }

        // crop pixel data if necessary
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let croppedBuffer = getCroppedPixelBuffer(pixelBuffer: pixelBuffer) else { return } //1
        
        let imageWidth = CVPixelBufferGetWidth(croppedBuffer)
        let imageHeight = CVPixelBufferGetHeight(croppedBuffer)

        if baseConfig.dataType == .video,
            let videoWriter = videoWriter,
            videoWriter.canWrite()
        {
            videoWriter.captureOutput(sampleBuffer: sampleBuffer)
        }

        guard let result = verify(pixelBuffer: croppedBuffer) else { return }

        // temporary workaround when resolving issue with Recoglib.getPreview dealocating of the std::vector type
        latestSuccessfullBuffer = result.isOk ? croppedBuffer : nil

        // SZENID-2123 - defer the start of the video after the ID was aligned
        if baseConfig.dataType == .video, 
            let documentResult = result as? DocumentResult,
            let hologramState = documentResult.hologramState
        {
            if videoWriter?.isRecording == false,
               [.TiltLeftAndRight, .TiltUpAndDown, .TiltUp, .TiltDown, .TiltLeft, .TiltRight].contains(hologramState)
            {
                DispatchQueue.main.async { [weak self] in
                    self?.startVideoWriter()
                }
            }
        }

        callUpdateDelegate(with: result)
        DispatchQueue.main.async { [weak self] in
            self?.updateView(with: result, buffer: croppedBuffer)
        }
        
        #if targetEnvironment(simulator)
        let canvasSize = CGSize(width: imageWidth, height: imageHeight)
        
        #else
        let canvasSize = previewFrame.size
        
        #endif
        guard let commands = getRenderCommands(size: canvasSize) else { return }
        var log = "RENDER: Commands | size: \(canvasSize) | frame: \(previewFrame) \n \(commands)"
        if log != temp {
            temp = log
            ApplicationLogger.shared.Info(log)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let previewFrame = self?.previewFrame else { return }
            
            self?.renderCommands(commands: commands, imageRect: previewFrame, pixelBuffer: pixelBuffer)
        }
    }
}
