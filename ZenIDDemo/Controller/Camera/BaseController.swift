import Foundation
import UIKit
import RecogLib_iOS
import AVFoundation

public protocol ResultState {
    var isOk: Bool { get }
    var description: String { get }
}

struct BaseControllerConfiguration {
    static let `default` = BaseControllerConfiguration(showVisualisation: true, dataType: .picture, cameraType: .back)
    
    public let showVisualisation: Bool
    public let dataType: DataType
    public let cameraType: CameraType
}

public class BaseController<ResultType: ResultState> {
    let camera: Camera
    let view: CameraView
    
    var videoWriter: VideoWriter?
    
    var targetFrame: CGRect = .zero
    var isRunning: Bool = false
    
    var previousResult: ResultType?
    
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
        
        view.layoutIfNeeded()
        
        try camera.configure(with: .init(type: configuration.cameraType))
        
        view.previewLayer = camera.previewLayer
        view.setup(isOtherDocument: false)
        view.setupControlView(isOtherDocument: false)
        view.supportChangedOrientation = { true }
        view.configureOverlay(overlay: CameraOverlayView(imageName: "targettingRect", frame: view.bounds), showStaticOverlay: canShowStaticOverlay(), targetFrame: getOverlayTargetFrame())
        view.configureVideoLayers(overlay: CameraOverlayView(imageName: "targettingRect", frame: view.bounds), showStaticOverlay: canShowStaticOverlay(), targetFrame: getOverlayTargetFrame())
        
        targetFrame = view.overlay?.bounds ?? .zero
        
        setTorch(on: baseConfig.dataType == .video)
        if baseConfig.dataType == .video {
            videoWriter = VideoWriter()
            videoWriter?.delegate = self
            let orientation = UIDevice.current.orientation
            videoWriter?.start(isPortrait: orientation == .portrait || orientation == .faceUp)
        }
        
        view.showInstructionView = canShowInstructionView()

        previousResult = nil
        orientationChanged()
        start()
        isRunning = true
        
        DispatchQueue.main.async {
            self.orientationChanged()
        }
    }
    
    func start() {
        camera.start()
    }
    
    func stop() {
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
        canShowVisualisation()
    }
    
    func canShowInstructionView() -> Bool {
        baseConfig.dataType != .video && canShowVisualisation()
    }
    
    func callDelegate(with result: ResultType) {
        
    }
    
    func callDelegate(with videoUrl: URL) {
        
    }
    
    @objc
    private func orientationChanged() {
        targetFrame = view.overlay?.bounds ?? .zero
        camera.setOrientation(orientation: UIDevice.current.orientation)
        view.drawLayer?.renderables = []
        view.rotateOverlay(targetFrame: getOverlayTargetFrame())
    }
}

extension BaseController {
    func getOverlayTargetFrame() -> CGRect {
        let size = camera.getCurrentResolution()
        let imageRect = CGRect(origin: .zero, size: size)
        return imageRect.rectThatFitsRect(view.overlay?.frame ?? .zero)
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
        if !baseConfig.showVisualisation {
            return
        }
        guard let previewLayer = camera.previewLayer else {
            return
        }
        if targetFrame == .zero {
            return
        }
        let commandsRect = previewLayer.frame
        if let drawLayer = view.drawLayer {
            let renderables = RenderableFactory.createRenderables(commands: commands)
            drawLayer.frame = commandsRect
            drawLayer.renderables = renderables
        }
    }
    
    func updateView(with result: ResultType?, buffer: CVPixelBuffer) {
        guard let unwrappedResult = result else {
            view.statusButton.setTitle("nil result", for: .normal)
            return
        }
        
        guard unwrappedResult.isOk, !(previousResult?.isOk ?? false) else {
            view.statusButton.setTitle(String(describing: unwrappedResult.description), for: .normal)
            return
        }
        previousResult = unwrappedResult
        
        debugPrint("Done")
        /*if photoType == .face && faceMode?.isFaceliveness ?? false {
            saveAuxiliaryImagesToLibrary(info: faceLivenessVerifier.getAuxiliaryInfo())
        }*/
        
        guard isRunning else { return }
        isRunning = false
        
        if baseConfig.dataType == .video {
            videoWriter?.stop()
            setTorch(on: false)
            return
        }
        callDelegate(with: unwrappedResult)
    }
    
    func canShowVisualisation() -> Bool {
        view.webViewOverlay == nil
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
        
        /*if faceMode == nil && photoType == .face {
            return
        }*/
        if let videoWriter = self.videoWriter, baseConfig.dataType == .video, videoWriter.isRecording {
            videoWriter.captureOutput(sampleBuffer: sampleBuffer)
        }
        guard let result = verify(pixelBuffer: croppedBuffer) else {
            return
        }
        DispatchQueue.main.async { [unowned self] in
            self.updateView(with: result, buffer: croppedBuffer)
        }
        let canvasSize = camera.previewLayer.frame.size
        guard let commands = getRenderCommands(size: canvasSize) else {
            return
        }
        DispatchQueue.main.async {
            self.renderCommands(commands: commands, imageRect: imageRect, pixelBuffer: pixelBuffer)
        }
    }
}
