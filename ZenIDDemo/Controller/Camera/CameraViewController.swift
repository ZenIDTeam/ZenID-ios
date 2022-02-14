
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
    }
    
    func start() {
        camera.start()
    }
    
    func stop() {
        camera.stop()
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
        camera.delegate = self
        
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
        camera.delegate = self
        
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
        camera.delegate = self
        
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
    
    // This enables / disables additional debug visualisation hints from the ZenID framework
    public var showVisualisationDebugInfo: Bool = true {
        didSet {
            documentVerifier.showDebugInfo = showVisualisationDebugInfo
            faceLivenessVerifier.showDebugInfo = showVisualisationDebugInfo
            selfieVerifier.showDebugInfo = showVisualisationDebugInfo
        }
    }
    
    // This enables / disables visualisation hints from the ZenID framework
    public var showVisualisation: Bool = true
    
    // Static overlay should be disabled when visualisation hints are enabled
    public var showStaticOverlay: Bool = false
    
    // This enables / disables the static text instructions
    public var showInstructionView: Bool = false {
        didSet {
            contentView.instructionView.isHidden = !showInstructionView
        }
    }
    
    public var photosCount: Int {
        didSet {
            contentView.saveTrigger.isHidden = photosCount == 0
        }
    }
    
    private var contentView: CameraView {
        view as! CameraView
    }
    
    private var targetFrame: CGRect = .zero
    
    private var photoType: PhotoType
    private var documentType: DocumentType
    private var country: Country
    private var faceMode: FaceMode?
    private var dataType: DataType
    
    private let camera = Camera()
    private var videoWriter: VideoWriter!
    
    private var documentVerifier: DocumentVerifier = DocumentVerifier(
                                                            role: RecogLib_iOS.DocumentRole.Idc,
                                                            country: RecogLib_iOS.Country.Cz,
                                                            page: RecogLib_iOS.PageCode.Front,
                                                            code: nil,
                                                            language: LanguageHelper.language)
    
//    private var documentVerifier: DocumentVerifier = DocumentVerifier(
//        acceptableInputJson: "{\"PossibleDocuments\":[{\"Role\":\"Idc\",\"Country\":\"Cz\",\"Page\":\"F\"}]}",
//        language: LanguageHelper.language)
    
    private var faceLivenessVerifier: FaceLivenessVerifier = FaceLivenessVerifier(language: LanguageHelper.language)
    private var selfieVerifier: SelfieVerifier = SelfieVerifier(language: LanguageHelper.language)
    
    private var detectionRunning = false;
    private var previousResult: UnifiedResult?
    
    private var supportChangedOrientation: Bool {
        return photoType != .face && dataType != .video
    }
    
    private var documents: [Document]
    private var documentSettings: DocumentVerifierSettings?
    
    private var webViewOverlay: WebViewOverlay?
    
    init(photoType: PhotoType, documentType: DocumentType, country: Country, faceMode: FaceMode, dataType: DataType) {
        self.photoType = photoType
        self.documentType = documentType
        self.country = country
        self.faceMode = faceMode
        self.dataType = dataType
        self.photosCount = 0
        self.documents = []
        
        super.init(nibName: nil, bundle: nil)
        camera.delegate = self
        loadModels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CameraView()
        contentView.supportChangedOrientation = { [unowned self] in
            self.supportChangedOrientation
        }
    }
    
    private func loadModels() {
        let rootUrl = URL.modelsFolder
        documentVerifier.loadModels(.init(url: URL.modelsDocuments)!)
        
        loadFacelivenessModels(isLegacy: true)
        
        let selfieUrl = rootUrl.appendingPathComponent("face")
        selfieVerifier.loadModels(.init(url: selfieUrl)!)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        contentView.saveTrigger.setTitle("\("btn-save".localized) (\(photosCount))", for: .normal)
        contentView.configureOverlay(overlay: CameraOverlayView(imageName: overlayImageName(), frame: contentView.cameraView.bounds), showStaticOverlay: canShowStaticOverlay(), targetFrame: getOverlayTargetFrame())
        DispatchQueue.main.async { [weak self] in
            self?.orientationChanged()
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        setNilAllPreviousResults()
        camera.start()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        
        // stop video recorder
        videoWriter?.delegate = nil
        videoWriter?.stop()
        videoWriter = nil
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        camera.stop()
        setTorch(on: false)
    }
    
    deinit {
        camera.stop()
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        targetFrame = contentView.overlay?.frame ?? .zero
    }
    
    private func loadFacelivenessModels(isLegacy: Bool) {
        let faceUrl = URL.modelsFolder.appendingPathComponent("face")
        let faceLoader = FaceVerifierModels(url: faceUrl)!
        faceLivenessVerifier.loadModels(faceLoader)
    }

    public func configureController(type: DocumentType, photoType: PhotoType, country: Country, faceMode: FaceMode?, photosCount: Int = 0, documents: [Document], documentSettings: DocumentVerifierSettings, config: Config) {
        if faceMode?.isFaceliveness ?? false && photoType == .face {
            let isLegacy = faceMode == .faceLivenessLegacy
            faceLivenessVerifier.update(settings: .init(isLegacyModeEnabled: isLegacy))
        }
        self.detectionRunning = false
        self.photoType = photoType
        self.documentType = type
        self.country = country
        self.faceMode = faceMode
        self.dataType = dataType(of: documentType, photoType: photoType, isLivenessVideo: config.isLivenessVideo)
        self.documents = documents
        
        self.title = type.title
        contentView.topLabel.text = photoType.message
        self.photosCount = photosCount
        
        if self.documentSettings != documentSettings {
            self.documentSettings = documentSettings
            documentVerifier.update(settings: documentSettings)
        }

        // Start video capture session
        self.startSession()
        
        resetDocumentVerifier()
        
        // Create verify object
        switch photoType {
        case .face:
            // Reset verifier
            self.faceLivenessVerifier.reset()
            self.selfieVerifier.reset()
            break
        default:
            // Reset verifier
            self.documentVerifier.reset()
            
            // This will setup document verifier to stop detect holograms
            self.documentVerifier.endHologramVerification()
            
            if type == .unspecifiedDocument {
                resetDocumentVerifier()
            } else {
                // This will setup document verifier
                if let role = RecoglibMapper.documentRole(from: type) {
                    documentVerifier.documentRole = role
                }
                if let documentPage = RecoglibMapper.pageCode(from: photoType) {
                    documentVerifier.page = documentPage
                }
                if let country = RecoglibMapper.country(from: country) {
                    documentVerifier.country = country
                }
                if let code = previousResult?.code, photoType == .back {
                    documentVerifier.code = code
                }
            }
            break
        }
        
        if dataType == .video {
            // Reset verifier
            self.documentVerifier.reset()
            
            // This will setup document verifier to Czech ID / front side
            //self.documentVerifier.documentRole = RecogLib_iOS.DocumentRole.Idc
            //self.documentVerifier.country = RecogLib_iOS.Country.Cz
            //self.documentVerifier.page = RecogLib_iOS.PageCode.Front
            
            // This will setup document verifier to detect holograms
            self.documentVerifier.beginHologramVerification()
            
            // This starts video writer for holograms
            self.videoWriter.start()
        }
        
        if type == .filter {
            documentVerifier.documentsInput = .init(documents: documents)
        }

        documentVerifier.showDebugInfo = config.isDebugEnabled
        faceLivenessVerifier.showDebugInfo = config.isDebugEnabled
        selfieVerifier.showDebugInfo = config.isDebugEnabled
        
        // This hides visualisation hints, overlay and instructions for generic documents
        if type == .otherDocument {
            self.showStaticOverlay = false
            self.showVisualisation = false
            self.showInstructionView = false
        } else {
            self.showStaticOverlay = true
            self.showVisualisation = canShowVisualisation()
            self.showInstructionView = canShowInstructionView()
        }
        
        // Control view
        contentView.setupControlView(isOtherDocument: documentType == .otherDocument)
        
        // Start detection
        self.detectionRunning = true
        
        setNilAllPreviousResults()
        orientationChanged()
    }
    
    private func dataType(of documentType: DocumentType, photoType: PhotoType, isLivenessVideo: Bool) -> DataType {
        if documentType == .documentVideo || photoType == .face && isLivenessVideo {
            return .video
        }
        return .picture
    }
    
    func addWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        let webView = WebViewOverlay()
        webView.loadOnline()
        view.addSubview(webView)
        view.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        webViewOverlay = webView
    }
    
    func removeWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        webViewOverlay = nil
    }
    
    private func resetDocumentVerifier() {
        documentVerifier.documentsInput = nil
        documentVerifier.documentRole = nil
        documentVerifier.page = nil
        documentVerifier.country = nil
        documentVerifier.code = nil
    }
    
    private func setNilAllPreviousResults() {
        previousResult = nil
    }
    
    public func showErrorMessage(_ message: String) {
        contentView.showErrorMessage(message)
    }

    public func showSuccess() {
        contentView.showSuccessMessage()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.black
        contentView.setup(isOtherDocument: documentType == .otherDocument)
        contentView.cameraTrigger.addTarget(self, action: #selector(capture), for: .touchUpInside)
        contentView.saveTrigger.addTarget(self, action: #selector(save), for: .touchUpInside)
    }

    private func updateView(with result: UnifiedResult?, photoType: PhotoType, buffer: CVPixelBuffer) {
        guard let unwrappedResult = result else {
            contentView.statusButton.setTitle("nil result", for: .normal)
            return
        }
        
        guard unwrappedResult.state == .ok, previousResult?.state != .ok else {
            contentView.statusButton.setTitle(String(describing: unwrappedResult.state.localizedDescription), for: .normal)
            return
        }
        previousResult = unwrappedResult
        
        if photoType == .face && faceMode?.isFaceliveness ?? false {
            saveAuxiliaryImagesToLibrary(info: faceLivenessVerifier.getAuxiliaryInfo())
        }
        
        guard detectionRunning else { return }
        detectionRunning = false
        
        if dataType == .video {
            videoWriter.stop()
        } else if photoType.isDocument {
            returnImage(buffer, result: unwrappedResult)
        } else {
            returnImage(buffer, result: unwrappedResult)
        }
    }
    
    private func saveAuxiliaryImagesToLibrary(info: FaceLivenessAuxiliaryInfo?) {
        for image in info?.images ?? [] {
            guard let image = UIImage(data: image) else {
                continue
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }

    @objc private func capture() {
        camera.takePicture { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                if let originalImage = UIImage(data: data), let previewLayer = self.camera.previewLayer, let croppedImage = originalImage.cropCameraImage(previewLayer: previewLayer) {
                    self.returnImage(croppedImage.jpegData(compressionQuality: 0.5))
                } else {
                    let resizedImageData = data.resizeImage(maxResolution: 2000, compression: 0.5)
                    self.returnImage(resizedImageData)
                }
            case let .failure(error):
                if case CameraError.notInitialized = error {
                    self.showErrorMessage("camera-not-authorized".localized)
                } else {
                    ApplicationLogger.shared.Error(error.localizedDescription)
                }
                self.returnImage(nil)
            }
        }
    }
    
    @objc private func save() {
        delegate?.didFinishPDF()
    }
    
    private func returnImage(_ buffer: CVPixelBuffer, result: UnifiedResult? = nil) {
        let image = UIImage(pixelBuffer: buffer)
        let data = image?.jpegData(compressionQuality: 0.5)
        returnImage(data, result)
    }
    
    private func returnImage(_ data: Data?, _ result: UnifiedResult? = nil) {
        if let data = data, let image = UIImage(data: data), let signatureImageData = result?.signature?.image, let signatureImage = UIImage(data: signatureImageData) {
            let preview = PreviewViewController(title:title ?? "", image: signatureImage)
            preview.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            preview.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            preview.saveAction = { [unowned self] in
                self.delegate?.didTakePhoto(data, type: self.photoType, result: result)
            }
            preview.dismissAction = { [unowned self] in
                self.setNilAllPreviousResults()
                self.detectionRunning = true
                self.documentVerifier.reset()
                self.faceLivenessVerifier.reset()
                self.selfieVerifier.reset()
            }

            present(preview, animated: true, completion: nil)
        }
        else {
            delegate?.didTakePhoto(nil, type: photoType, result: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setTorch(on: Bool) {
        do {
            try camera.setTorch(isOn: on)
        } catch {
            ApplicationLogger.shared.Verbose("\(error.localizedDescription)")
        }
    }
    
    @objc func orientationChanged() {
        camera.setOrientation(orientation: UIDevice.current.orientation)
        contentView.drawLayer?.renderables = []
        contentView.rotateOverlay(targetFrame: getOverlayTargetFrame())
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
            let configuration = CameraConfiguration(type: photoType == .face ? .front : .back)
            try camera.configure(with: configuration)
            videoWriter = VideoWriter()
            videoWriter.delegate = self
        } catch {
            returnImage(nil)
            return
        }
        contentView.previewLayer = camera.previewLayer
        contentView.configureVideoLayers(overlay: CameraOverlayView(imageName: overlayImageName(), frame: contentView.cameraView.bounds), showStaticOverlay: canShowStaticOverlay(), targetFrame: getOverlayTargetFrame())
    }
    
    private func getOverlayTargetFrame() -> CGRect {
        let size = camera.getCurrentResolution()
        let imageRect = CGRect(origin: .zero, size: size)
        return imageRect.rectThatFitsRect(targetFrame)
    }
    
    private func canShowStaticOverlay() -> Bool {
        showStaticOverlay && photoType != .face && webViewOverlay == nil
    }
    
    private func canShowInstructionView() -> Bool {
        (photoType != .face && faceMode == .faceLiveness) && dataType != .video && webViewOverlay == nil
    }
    
    private func canShowVisualisation() -> Bool {
        webViewOverlay == nil
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

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension CameraViewController: CameraDelegate {
    private func getCroppedTargetFrame(width: Int, height: Int) -> CGRect {
        let gravity = Defaults.videoGravity
        switch gravity {
        case .resizeAspect:
            let imageRect = CGRect(x: 0, y: 0, width: width, height: height)
            let croppedTargetFrame = imageRect.rectThatFitsRect(targetFrame)
            return croppedTargetFrame
            
        case .resizeAspectFill:
            return targetFrame
            
        default:
            return .zero
        }
    }
    
    private func getCroppedImageRect(width: Int, height: Int) -> CGRect {
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
    
    private func getCroppedPixelBuffer(pixelBuffer: CVPixelBuffer) -> CVPixelBuffer {
        // camera frame size
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        
        // find cropping
        let cropRect = getCroppedImageRect(width: width, height: height)
        
        // create (cropped) image
        let image = UIImage(pixelBuffer: pixelBuffer, crop: cropRect)
        return (image?.toCVPixelBuffer())!
    }
    
    func cameraDelegate(camera: Camera, onOutput buffer: CMSampleBuffer) {
        guard detectionRunning else { return }
        guard targetFrame.width > 0 else { return }
        
        // crop pixel data if necessary
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else { return }
        let croppedBuffer = getCroppedPixelBuffer(pixelBuffer: pixelBuffer)
        let imageWidth = CVPixelBufferGetWidth(croppedBuffer)
        let imageHeight = CVPixelBufferGetHeight(croppedBuffer)
        let imageRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        
        // torch for holograms
        self.setTorch(on: dataType == .video && photoType != .face)
        
        if faceMode == nil && photoType == .face {
            return
        }
        if let videoWriter = self.videoWriter, dataType == .video, videoWriter.isRecording {
            videoWriter.captureOutput(sampleBuffer: buffer)
        }
        let verifier = getVerifier(photoType: photoType, faceMode: faceMode ?? .selfie)
        guard let result = verifier.verify(image: croppedBuffer) else {
            return
        }
        DispatchQueue.main.async { [unowned self] in
            self.webViewOverlay?.updateState(state: getWebViewOverlayState(result: result))
            self.updateView(with: result, photoType: photoType, buffer: croppedBuffer)
        }
        guard let renderable = getVerifierRenderable(photoType: photoType, faceMode: faceMode ?? .selfie) else {
            return
        }
        DispatchQueue.main.async {
            self.renderCommands(renderable: renderable, imageRect: imageRect, pixelBuffer: pixelBuffer)
        }
    }
    
    private func renderCommands(renderable: VerifierRenderable, imageRect: CGRect, pixelBuffer: CVPixelBuffer) {
        if !showVisualisation {
            return
        }
        guard let previewLayer = camera.previewLayer else {
            return
        }
        if targetFrame == .zero {
            return
        }
        let commandsRect = previewLayer.frame
        guard let renderCommands = renderable.getRenderCommands(canvasSize: commandsRect.size) else {
            return
        }
        
        if let drawLayer = contentView.drawLayer {
            let renderables = RenderableFactory.createRenderables(commands: renderCommands)
            drawLayer.frame = commandsRect
            drawLayer.renderables = renderables
        }
    }
    
    private func getVerifier(photoType: PhotoType, faceMode: FaceMode) -> UnifiedVerifier {
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
    }
}

// MARK: - VideoWriterDelegate
extension CameraViewController: VideoWriterDelegate {
    public func didTakeVideo(_ videoAsset: AVURLAsset) {
        delegate?.didTakeVideo(videoAsset, type: self.photoType)
    }
}
