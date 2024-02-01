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

    static let `default` = BaseControllerConfiguration(showVisualisation: true, showHelperVisualisation: true, dataType: .picture, cameraType: .back, requestedResolution: Self.DEFAULT_VIDEO_RESOLUTION, requestedFPS: Self.DEFAULT_VIDEO_FPS, processType: .document)

    public let showVisualisation: Bool
    public let showHelperVisualisation: Bool
    public let dataType: DataType
    public let cameraType: CameraType
    public let requestedResolution: Int
    public let requestedFPS: Int
    public let processType: ProcessType

    init(showVisualisation: Bool, showHelperVisualisation: Bool, dataType: DataType, cameraType: CameraType, requestedResolution: Int, requestedFPS: Int, processType: ProcessType) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
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
    public var camera: Camera
    public weak var view: CameraView?

    var videoWriter: VideoWriter?

    var targetFrame: CGRect = .zero
    var isRunning: Bool = false

    var previousResult: ResultType?
    var latestSuccessfullBuffer: CVPixelBuffer?

    var overlayImageName: String {
        "targettingRect"
    }

    private(set) var baseConfig: BaseControllerConfiguration = .default

    init(camera: Camera, view: CameraView) {
        self.camera = camera
        self.view = view

        NotificationCenter.default.addObserver(
            self, selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification, object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        setTorch(on: false)
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
        view?.setupControlView()
        view?.supportChangedOrientation = { true }
        view?.onFrameChange = { [weak self] in
            self?.orientationChanged()
        }

        view?.configureOverlay(overlay: CameraOverlayView(imageName: overlayImageName, frame: view?.bounds ?? .zero), showStaticOverlay: canShowStaticOverlay(), targetFrame: getOverlayTargetFrame())
        view?.configureVideoLayers(overlay: CameraOverlayView(imageName: overlayImageName, frame: view?.bounds ?? .zero), showStaticOverlay: canShowStaticOverlay(), targetFrame: getOverlayTargetFrame())

        targetFrame = view?.overlay?.bounds ?? .zero

        if baseConfig.dataType == .video {
            videoWriter = VideoWriter()
            videoWriter?.delegate = self

            // start camera for face liveness and don't defer the start of the video after the ID was aligned (SZENID-2123)
            if baseConfig.processType == .face {
                startVideoWriter()
            }
        }

        view?.showInstructionView = canShowInstructionView()

        previousResult = nil
        orientationChanged()
        start()
        isRunning = true

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.orientationChanged()
            self.setTorch(on: self.baseConfig.dataType == .video)
        }
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

    func verify(pixelBuffer: CVPixelBuffer) -> ResultType? {
        nil
    }

    func getRenderCommands(size: CGSize) -> String? {
        nil
    }

    func canShowStaticOverlay() -> Bool {
        canShowVisualisation() && isVisualisationAllowed()
    }

    func canShowInstructionView() -> Bool {
        baseConfig.dataType != .video && canShowStaticOverlay()
    }

    func callDelegate(with result: ResultType) {
    }

    func callDelegate(with videoUrl: URL) {
    }

    func callUpdateDelegate(with result: ResultType) {
    }

    @objc
    private func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.updateOrientation()
        }
    }

    @objc
    private func updateOrientation() {
        targetFrame = view?.overlay?.bounds ?? .zero
        camera.setOrientation(orientation: UIDevice.current.orientation)
        view?.drawLayer?.setRenderables([])
        view?.rotateOverlay(targetFrame: getOverlayTargetFrame())

        restartVideoWriter()
    }

    private func isVisualisationAllowed() -> Bool {
        baseConfig.showVisualisation
    }
    
    /// Restart video recording.
    func restartVideoWriter() {
        guard let videoWriter = videoWriter, videoWriter.isRecording else { return }
        
        videoWriter.stopAndCancel()
        DispatchQueue.main.async { [weak self] in
            self?.startVideoWriter()
        }
    }

    private func startVideoWriter() {
        let orientation: UIInterfaceOrientation
        orientation = if #available(iOS 15.0, *) {
            UIApplication
                .shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last?.windowScene?.interfaceOrientation ?? .portrait
        } else if #available(iOS 13.0, *) {
            UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .last { $0.isKeyWindow }?
                .windowScene?.interfaceOrientation ?? .portrait
        } else {
            UIApplication.shared.statusBarOrientation
        }
        videoWriter?.start(isPortrait: orientation.isPortrait, requestedWidth: baseConfig.requestedResolution, requestedFPS: baseConfig.requestedFPS)
    }
}

extension BaseController {
    func getOverlayTargetFrame() -> CGRect {
        let size = camera.getCurrentResolution()
        let imageRect = CGRect(origin: .zero, size: size)
        return imageRect.rectThatFitsRect(view?.overlay?.frame ?? .zero)
    }

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

    func getCroppedImageRect(width: Int, height: Int) -> CGRect {
        #if targetEnvironment(simulator)
            return CGRect(x: 0, y: 0, width: width, height: height)
        #endif
        let gravity = Defaults.videoGravity
        switch gravity {
        case .resizeAspect:
            let imageRect = CGRect(x: 0, y: 0, width: width, height: height)
            let layerRect = imageRect.rectThatFitsRect(targetFrame)
            let metadataRect = camera.previewLayer!.metadataOutputRectConverted(fromLayerRect: layerRect)
            let cropRect = metadataRect.applying(CGAffineTransform(scaleX: CGFloat(width), y: CGFloat(height)))
            return cropRect
        case .resizeAspectFill:
            let layerRect = targetFrame
            let metadataRect = camera.previewLayer!.metadataOutputRectConverted(fromLayerRect: layerRect)
            let cropRect = metadataRect.applying(CGAffineTransform(scaleX: CGFloat(width), y: CGFloat(height)))
            return cropRect
        default:
            return .zero
        }
    }

    func setTorch(on: Bool) {
        do {
            try camera.setTorch(isOn: on)
        } catch {
            ApplicationLogger.shared.Verbose("\(error.localizedDescription)")
        }
    }

    func renderCommands(commands: String, imageRect: CGRect, pixelBuffer: CVPixelBuffer) {
        if !baseConfig.showHelperVisualisation {
            return
        }
        guard let previewLayer = camera.previewLayer else {
            return
        }
        if targetFrame == .zero {
            return
        }
        let commandsRect = previewLayer.frame
        if let drawLayer = view?.drawLayer {
            let renderables = RenderableFactory.createRenderables(commands: commands)
            drawLayer.frame = commandsRect
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
            setTorch(on: false)
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
        guard targetFrame.width > 0 else { return }

        // crop pixel data if necessary
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let croppedBuffer = getCroppedPixelBuffer(pixelBuffer: pixelBuffer) else {
            return
        }
        let imageWidth = CVPixelBufferGetWidth(croppedBuffer)
        let imageHeight = CVPixelBufferGetHeight(croppedBuffer)
        let imageRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)

        if baseConfig.dataType == .video, let videoWriter = videoWriter, videoWriter.canWrite() {
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
        DispatchQueue.main.async { [unowned self] in
            self.updateView(with: result, buffer: croppedBuffer)
        }
        #if targetEnvironment(simulator)
            let canvasSize = CGSize(width: imageWidth, height: imageHeight)
        #else
            guard let canvasSize = camera.previewLayer?.frame.size else { return }
        #endif

        guard let commands = getRenderCommands(size: canvasSize) else { return }
        DispatchQueue.main.async {
            self.renderCommands(commands: commands, imageRect: imageRect, pixelBuffer: pixelBuffer)
        }
    }
}
