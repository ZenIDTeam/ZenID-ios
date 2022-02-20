
import AVFoundation
import CoreGraphics
import RecogLib_iOS
import UIKit
import WebKit


struct CameraConfiguration {
    public let type: CameraType
}

enum CameraError: Error {
    case notInitialized
}

enum CameraType {
    case front
    case back
}

public enum DataType {
    case picture
    case video
}

protocol CameraDelegate: AnyObject {
    func cameraDelegate(camera: Camera, onOutput sampleBuffer: CMSampleBuffer)
}

final class Camera: NSObject {
    weak var delegate: CameraDelegate?
    private(set) var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    private var cameraVideoOutput: AVCaptureVideoDataOutput!
    
    private var takePictureCompletion: ((Swift.Result<Data, Swift.Error>) -> Void)?
    
    func configure(with configuration: CameraConfiguration) throws {
        let captureDevicePosition: AVCaptureDevice.Position = configuration.type == .back ? .back : .front
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: captureDevicePosition
        )
        captureDevice = deviceDescoverySession.devices.first
        
        guard let device = captureDevice, setupCameraSession(device) else {
            throw CameraError.notInitialized
        }
        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        }
    }
    
    func start() {
        captureSession.startRunning()
    }
    
    func stop() {
        captureSession.stopRunning()
    }
    
    func takePicture(completion: @escaping (Swift.Result<Data, Swift.Error>) -> Void) {
        guard captureDevice != nil else {
            completion(.failure(CameraError.notInitialized))
            return
        }
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            completion(.failure(CameraError.notInitialized))
            return
        }
        takePictureCompletion = completion
        cameraPhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    func setOrientation(orientation: UIDeviceOrientation) {
        switch UIDevice.current.orientation {
        case .portrait:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        case .landscapeLeft:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        case .portraitUpsideDown:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
        default: break
        }
        
        if #available(iOS 13.0, *) {
            for connection in captureSession.connections {
                connection.videoOrientation = previewLayer.connection?.videoOrientation ?? .portrait
            }
        }
    }
    
    func setTorch(isOn: Bool) throws {
        guard let device = captureDevice, device.hasTorch else { return }
        guard isOn || device.torchMode != .off else { return }
        
        let torchMode: AVCaptureDevice.TorchMode = isOn ? .on : .off
        guard device.torchMode != torchMode else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
            } catch {
                throw error
            }
            device.torchMode = torchMode
        }
        device.unlockForConfiguration()
    }

    func getCurrentResolution() -> CGSize {
        guard let formatDescription = captureDevice?.activeFormat.formatDescription else {
            return .zero
        }
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
        return CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            takePictureCompletion?(.failure(error))
        } else if let data = photo.fileDataRepresentation() {
            takePictureCompletion?(.success(data))
        }
        takePictureCompletion = nil
    }
}

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.cameraDelegate(camera: self, onOutput: sampleBuffer)
    }
}

private extension Camera {
    func setupCameraSession(_ device: AVCaptureDevice) -> Bool {
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return false
        }
        
        previewLayer?.videoGravity = Defaults.videoGravity
        
        captureSession.beginConfiguration()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }
        
        cameraPhotoOutput = AVCapturePhotoOutput()
        cameraVideoOutput = AVCaptureVideoDataOutput()
        
        captureSession.addInput(input)
        captureSession.addOutput(cameraPhotoOutput)
        cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA] as [String : Any]
        cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)
        captureSession.addOutput(cameraVideoOutput)

        captureSession.commitConfiguration()

        return true
    }
}

struct BaseControllerConfiguration {
    static let `default` = BaseControllerConfiguration(showVisualisation: true, dataType: .picture, cameraType: .back)
    
    public let showVisualisation: Bool
    public let dataType: DataType
    public let cameraType: CameraType
}

struct DocumentControllerConfiguration {
    public static let `default` = DocumentControllerConfiguration(
        showVisualisation: true,
        showDebugVisualisation: false,
        dataType: .picture,
        role: nil,
        country: nil,
        page: nil,
        code: nil,
        documents: nil,
        settings: nil
    )
    
    public let showVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let page: RecogLib_iOS.PageCode?
    public let code: RecogLib_iOS.DocumentCode?
    public let documents: [Document]?
    public let settings: DocumentVerifierSettings?
}

protocol ResultState {
    var isOk: Bool { get }
    var description: String { get }
}

extension DocumentResult: ResultState {
    var isOk: Bool {
        state == .Ok || hologremState == .ok
    }
    
    var description: String {
        state.localizedDescription
    }
}

class BaseController<ResultType: ResultState> {
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
            videoWriter?.start()
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

protocol DocumentControllerDelegate: AnyObject {
    func controller(_ controller: DocumentController, didScan result: DocumentResult)
    func controller(_ controller: DocumentController, didRecord videoURL: URL)
}

final class DocumentController: BaseController<DocumentResult> {
    weak var delegate: DocumentControllerDelegate?
    
    private let verifier: DocumentVerifier
    
    private var config = DocumentControllerConfiguration.default
    
    init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(
            role: RecogLib_iOS.DocumentRole.Idc,
            country: RecogLib_iOS.Country.Cz,
            page: RecogLib_iOS.PageCode.Front,
            code: nil,
            language: LanguageHelper.language
        )
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    deinit {
        verifier.endHologramVerification()
    }
    
    func configure(configuration: DocumentControllerConfiguration = .default) throws {
        verifier.reset()
        verifier.endHologramVerification()
        let oldConfig = self.config
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation && canShowVisualisation(),
            dataType: configuration.dataType,
            cameraType: .back
        )
        
        resetDocumentVerifier()
        
        if let config = config.settings, config != oldConfig.settings {
            verifier.update(settings: config)
        }
        
        // This will setup document verifier
        if let role = config.role {
            verifier.documentRole = role
        }
        if let page = config.page {
            verifier.page = page
        }
        if let country = config.country {
            verifier.country = country
        }
        if let code = previousResult?.code, config.page == .Back {
            verifier.code = code
        }
        if let documents = config.documents {
            verifier.documentsInput = .init(documents: documents)
        }
        
        if config.dataType == .video {
            verifier.beginHologramVerification()
        }
        
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
        
        //contentView.topLabel.text = photoType.message
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> DocumentResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer)
    }
    
    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }
    
    override func callDelegate(with result: DocumentResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        delegate?.controller(self, didRecord: videoUrl)
    }
    
    private func loadModels(url: URL) {
        verifier.loadModels(.init(url: url)!)
    }
    
    private func resetDocumentVerifier() {
        verifier.documentsInput = nil
        verifier.documentRole = nil
        verifier.page = nil
        verifier.country = nil
        verifier.code = nil
    }
}

extension SelfieResult: ResultState {
    var isOk: Bool {
        selfieState == .Ok
    }
    
    var description: String {
        selfieState.description
    }
}

struct SelfieControllerConfiguration {
    public static let `default` = SelfieControllerConfiguration(
        showVisualisation: true,
        showDebugVisualisation: false,
        dataType: .picture
    )
    
    public let showVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
}

protocol SelfieControllerDelegate: AnyObject {
    func controller(_ controller: SelfieController, didScan result: SelfieResult)
    func controller(_ controller: SelfieController, didRecord videoURL: URL)
}

final class SelfieController: BaseController<SelfieResult> {
    weak var delegate: SelfieControllerDelegate?
    
    private let verifier: SelfieVerifier
    
    private var config = SelfieControllerConfiguration.default
    
    init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(language: LanguageHelper.language)
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    func configure(configuration: SelfieControllerConfiguration = .default) throws {
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation && canShowVisualisation(),
            dataType: configuration.dataType,
            cameraType: .front
        )
        
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
        
        //contentView.topLabel.text = photoType.message
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> SelfieResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer)
    }
    
    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }
    
    override func canShowStaticOverlay() -> Bool {
        false
    }
    
    override func canShowInstructionView() -> Bool {
        false
    }
    
    override func callDelegate(with result: SelfieResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        delegate?.controller(self, didRecord: videoUrl)
    }
    
    private func loadModels(url: URL) {
        verifier.loadModels(.init(url: url)!)
    }
}


extension FaceLivenessResult: ResultState {
    var isOk: Bool {
        faceLivenessState == .Ok
    }
    
    var description: String {
        faceLivenessState.description
    }
}

struct FacelivenessControllerConfiguration {
    public static let `default` = FacelivenessControllerConfiguration(
        showVisualisation: true,
        showDebugVisualisation: false,
        dataType: .picture,
        isLegacy: false
    )
    
    public let showVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    public let isLegacy: Bool
}

protocol FacelivenessControllerDelegate: AnyObject {
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult)
    func controller(_ controller: FacelivenessController, didRecord videoURL: URL)
}

final class FacelivenessController: BaseController<FaceLivenessResult> {
    weak var delegate: FacelivenessControllerDelegate?
    
    private let verifier: FaceLivenessVerifier
    
    private var config = FacelivenessControllerConfiguration.default
    
    init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(language: LanguageHelper.language)
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    func configure(configuration: FacelivenessControllerConfiguration = .default) throws {
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation && canShowVisualisation(),
            dataType: configuration.dataType,
            cameraType: .front
        )
        
        verifier.update(settings: .init(isLegacyModeEnabled: configuration.isLegacy))
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
        
        //contentView.topLabel.text = photoType.message
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> FaceLivenessResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer)
    }
    
    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }
    
    override func canShowStaticOverlay() -> Bool {
        false
    }
    
    override func canShowInstructionView() -> Bool {
        false
    }
    
    override func callDelegate(with result: FaceLivenessResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        delegate?.controller(self, didRecord: videoUrl)
    }
    
    private func loadModels(url: URL) {
        guard let models = FaceVerifierModels(url: url) else {
            return
        }
        verifier.loadModels(models)
    }
}


class CameraViewController: UIViewController {
    weak var delegate: CameraViewControllerDelegate?
    
    private var contentView: CameraView {
        view as! CameraView
    }
    
    private var targetFrame: CGRect = .zero
    
    private var photoType: PhotoType
    private var documentType: DocumentType
    private var faceMode: FaceMode?
    private var dataType: DataType
    
    private let camera = Camera()

    private var documentController: DocumentController?
    private var documentControllerConfig: DocumentControllerConfiguration?
    private var selfieController: SelfieController?
    private var selfieControllerConfig: SelfieControllerConfiguration?
    private var facelivenessController: FacelivenessController?
    private var facelivenessControllerConfig: FacelivenessControllerConfiguration?
    
    init(photoType: PhotoType, documentType: DocumentType, faceMode: FaceMode, dataType: DataType) {
        self.photoType = photoType
        self.documentType = documentType
        self.faceMode = faceMode
        self.dataType = dataType
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CameraView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDocumentController()
        setupFacelivenessController()
        setupSelfieController()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        documentController?.start()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        documentController?.stop()
    }
    
    deinit {
        documentController?.stop()
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    public func configureController(type: DocumentType, photoType: PhotoType, country: Country, faceMode: FaceMode?, documents: [Document], documentSettings: DocumentVerifierSettings, config: Config) {
        self.photoType = photoType
        self.documentType = type
        self.faceMode = faceMode
        self.dataType = dataType(of: documentType, photoType: photoType, isLivenessVideo: config.isLivenessVideo)
        
        self.title = type.title
        contentView.topLabel.text = photoType.message

        startSession()
        
        documentControllerConfig = nil
        
        if photoType.isDocument {
            documentControllerConfig = .init(
                showVisualisation: true,
                showDebugVisualisation: config.isDebugEnabled,
                dataType: dataType,
                role: RecoglibMapper.documentRole(from: type),
                country: country.recoglibCountry,
                page: photoType == .front ? .Front : .Back,
                code: nil,
                documents: type == .filter ? documents : nil,
                settings: documentSettings
            )
            updateDocumentController()
        } else {
            if faceMode?.isFaceliveness ?? false {
                facelivenessControllerConfig = .init(
                    showVisualisation: true,
                    showDebugVisualisation: config.isDebugEnabled,
                    dataType: dataType,
                    isLegacy: faceMode == .faceLivenessLegacy
                )
                updateFacelivenessController()
            } else if faceMode == .selfie {
                selfieControllerConfig = .init(
                    showVisualisation: true,
                    showDebugVisualisation: config.isDebugEnabled,
                    dataType: dataType
                )
                updateSelfieController()
            }
        }
    }
    
    private func dataType(of documentType: DocumentType, photoType: PhotoType, isLivenessVideo: Bool) -> DataType {
        if documentType == .documentVideo || photoType == .face && isLivenessVideo {
            return .video
        }
        return .picture
    }
    
    public func showErrorMessage(_ message: String) {
        contentView.showErrorMessage(message)
    }

    public func showSuccess() {
        contentView.showSuccessMessage()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.black
    }
    
    private func saveAuxiliaryImagesToLibrary(info: FaceLivenessAuxiliaryInfo?) {
        for image in info?.images ?? [] {
            guard let image = UIImage(data: image) else {
                continue
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    private func returnImage(_ buffer: CVPixelBuffer, result: UnifiedResult? = nil) {
        let image = UIImage(pixelBuffer: buffer)
        let data = image?.jpegData(compressionQuality: 0.5)
        returnImage(data, result)
    }
    
    private func returnImage(_ data: Data?, _ result: UnifiedResult? = nil) {
        if let signatureImageData = result?.signature?.image, let signatureImage = UIImage(data: signatureImageData) {
            let preview = PreviewViewController(title:title ?? "", image: signatureImage)
            preview.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            preview.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            preview.saveAction = { [unowned self] in
                self.delegate?.didTakePhoto(signatureImageData, type: self.photoType, result: result)
            }
            preview.dismissAction = { [unowned self] in
                self.updateDocumentController()
            }

            present(preview, animated: true, completion: nil)
        }
        else {
            delegate?.didTakePhoto(nil, type: photoType, result: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setupDocumentController() {
        documentController = DocumentController(camera: camera, view: contentView, modelsUrl: URL.modelsDocuments)
        documentController?.delegate = self
    }
    
    func setupFacelivenessController() {
        facelivenessController = FacelivenessController(camera: camera, view: contentView, modelsUrl: URL.modelsFolder.appendingPathComponent("face"))
        facelivenessController?.delegate = self
    }
    
    func setupSelfieController() {
        selfieController = SelfieController(camera: camera, view: contentView, modelsUrl: URL.modelsFolder.appendingPathComponent("face"))
        selfieController?.delegate = self
    }
    
    func updateDocumentController() {
        guard let configuration = documentControllerConfig else {
            return
        }
        do {
            try documentController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
    
    func updateFacelivenessController() {
        guard let configuration = facelivenessControllerConfig else {
            return
        }
        do {
            try facelivenessController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
    
    func updateSelfieController() {
        guard let configuration = selfieControllerConfig else {
            return
        }
        do {
            try selfieController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
}

extension CameraViewController: DocumentControllerDelegate {
    func controller(_ controller: DocumentController, didScan result: DocumentResult) {
        returnImage(nil, UnifiedDocumentResultAdapter(result: result))
    }
    
    func controller(_ controller: DocumentController, didRecord videoURL: URL) {
        delegate?.didTakeVideo(videoURL, type: photoType)
    }
}

extension CameraViewController: FacelivenessControllerDelegate {
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult) {
        returnImage(nil, UnifiedFacelivenessResultAdapter(result: result))
    }
    
    func controller(_ controller: FacelivenessController, didRecord videoURL: URL) {
        delegate?.didTakeVideo(videoURL, type: photoType)
    }
}

extension CameraViewController: SelfieControllerDelegate {
    func controller(_ controller: SelfieController, didScan result: SelfieResult) {
        returnImage(nil, UnifiedSelfieResultAdapter(result: result))
    }
    
    func controller(_ controller: SelfieController, didRecord videoURL: URL) {
        delegate?.didTakeVideo(videoURL, type: photoType)
    }
}

// MARK: - Methods for AV session
private extension CameraViewController {
    
    func startSession() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            beginSession()
        case .notDetermined:
            getAccessToCamera()
        case .denied, .restricted:
            returnImage(nil)
        @unknown default:
            returnImage(nil)
        }
    }
    
    func getAccessToCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            return
        }

        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            DispatchQueue.main.async { [unowned self] in
                if granted {
                    self.beginSession()
                } else {
                    self.returnImage(nil)
                }
            }
        })
    }
    
    func beginSession() {
        do {
            
        } catch {
            returnImage(nil)
            return
        }
    }
    
    
    private func overlayImageName() -> String {
        if documentType == .passport {
            return "targettingRectPas"
        } else if documentType == .idCard {
            return "targettingRect"
        }
        return ""
    }
}

extension CameraViewController {
    /*private func getVerifier(photoType: PhotoType, faceMode: FaceMode) -> UnifiedVerifier {
        switch photoType {
        case .face:
            switch faceMode {
            case .faceLiveness, .faceLivenessLegacy:
                return UnifiedFacelivenessVerifierAdapter(verifier: faceLivenessVerifier)
            case .selfie:
                return UnifiedSelfieVerifierAdapter(verifier: selfieVerifier)
            }
        default:
            return UnifiedDocumentVerifierAdapter(verifier: documentVerifier, orientation: .portrait)
        }
    }
    
    private func getVerifierRenderable(photoType: PhotoType, faceMode: FaceMode) -> VerifierRenderable? {
        switch photoType {
        case .face:
            switch faceMode {
            case .faceLiveness, .faceLivenessLegacy:
                return UnifiedFacelivenessVerifierAdapter(verifier: faceLivenessVerifier)
            case .selfie:
                return UnifiedSelfieVerifierAdapter(verifier: selfieVerifier)
            }
        default:
            return UnifiedDocumentVerifierAdapter(verifier: documentVerifier, orientation: .portrait)
        }
    }
    
    private func getWebViewOverlayState(result: UnifiedResult) -> WebViewOverlayState {
        .init(
            page: photoType.pageCode,
            state: String(describing: result.state),
            frame: getCroppedTargetFrame(width: Int(contentView.previewLayer!.frame.width), height: Int(contentView.previewLayer!.frame.height))
        )
    }*/
}
