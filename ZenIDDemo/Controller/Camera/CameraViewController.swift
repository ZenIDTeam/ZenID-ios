
import AVFoundation
import CoreGraphics
import RecogLib_iOS
import UIKit
import WebKit


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
    private var deviceOrientation = UIInterfaceOrientation.landscapeLeft
    
    private var photoType: PhotoType
    private var documentType: DocumentType
    private var country: Country
    private var faceMode: FaceMode?
    private var dataType: DataType

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    private var captureDevicePosition: AVCaptureDevice.Position = .back
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    private var cameraVideoOutput: AVCaptureVideoDataOutput!
    private var videoWriter: VideoWriter!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
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
    
    private var isFaceDetection: Bool {
        return photoType == .face
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
        contentView.isFaceDetection = { [unowned self] in
            self.isFaceDetection
        }
        contentView.getCurrentResolution = { [unowned self] in
            self.getCurrentResolution()
        }
        contentView.targetFrame = { [unowned self] in
            self.targetFrame
        }
        contentView.deviceOrientation = { [unowned self] in
            self.deviceOrientation
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
        contentView.configureOverlay(overlay: CameraOverlayView(documentType: documentType, photoType: photoType, frame: contentView.cameraView.bounds), showStaticOverlay: canShowStaticOverlay())
        DispatchQueue.main.async { [weak self] in
            self?.orientationChanged()
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        setNilAllPreviousResults()
        captureSession.startRunning()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        
        // stop video recorder
        videoWriter?.delegate = nil
        videoWriter?.stop()
        videoWriter = nil
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        captureSession.stopRunning()
        setTorch(on: false)
    }
    
    deinit {
        captureSession.stopRunning()
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
        self.captureDevicePosition = isFaceDetection ? .front : .back
        contentView.rotateInstructionView()
        
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
            self.documentVerifier.documentRole = RecogLib_iOS.DocumentRole.Idc
            self.documentVerifier.country = RecogLib_iOS.Country.Cz
            self.documentVerifier.page = RecogLib_iOS.PageCode.Front
            
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
            returnImage(buffer, ImageFlip.fromLandScape, result: unwrappedResult)
        } else {
            returnImage(buffer, ImageFlip.fromPortrait, result: unwrappedResult)
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
        guard captureDevice != nil else {
            return
        }

        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            showErrorMessage("camera-not-authorized".localized)
            return
        }

        cameraPhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc private func save() {
        delegate?.didFinishPDF()
    }
    
    private func returnImage(_ buffer: CVPixelBuffer, _ flipMethod: ImageFlip, result: UnifiedResult? = nil) {
        let image = UIImage(pixelBuffer: buffer)//?.flip(flipMethod)
        let data = image?.jpegData(compressionQuality: 0.5)
        returnImage(data, result)
    }
    
    private func returnImage(_ data: Data?, _ result: UnifiedResult? = nil) {
        if let data = data, let image = UIImage(data: data) {
            let preview = PreviewViewController(title:title ?? "", image: image)
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
        guard let device = self.captureDevice else { return }
        Torch.shared.ensureMode(for: device, on: on)
    }
    
    @objc func orientationChanged() {
        switch UIDevice.current.orientation {
        case .portrait:           deviceOrientation = .portrait
        //case .portraitUpsideDown: self.deviceOrientation = .portraitUpsideDown
        case .portraitUpsideDown: return
        case .landscapeLeft:      deviceOrientation = .landscapeLeft
        case .landscapeRight:     deviceOrientation = .landscapeRight
        default: break;
        }
        
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
        } else {
            // Fallback on earlier versions
        }
        contentView.drawLayer?.renderables = []
        contentView.rotateOverlay()
        contentView.rotateInstructionView()
    }
}

// MARK: - Methods for AV session
private extension CameraViewController {
    func updateCaptureDevice() {
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: self.captureDevicePosition)
        self.captureDevice = deviceDescoverySession.devices.first
    }
    
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
        self.updateCaptureDevice()
        guard let device = captureDevice, setupCameraSession(device) else {
            returnImage(nil)
            return
        }
        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            contentView.previewLayer = previewLayer
        }
        contentView.configureVideoLayers(overlay: CameraOverlayView(documentType: documentType, photoType: photoType, frame: contentView.cameraView.bounds), showStaticOverlay: canShowStaticOverlay())
    }
    
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

        videoWriter = VideoWriter(cameraVideoOutput: cameraVideoOutput)
        videoWriter.delegate = self
        
        //for video aspect ratio/gravity testing
        //captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        
        captureSession.addInput(input)
        captureSession.addOutput(cameraPhotoOutput)
        cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA] as [String : Any]
        cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)
        captureSession.addOutput(cameraVideoOutput)

        captureSession.commitConfiguration()

        return true
    }
    
    private func getCurrentResolution() -> CGSize {
        guard let formatDescription = captureDevice?.activeFormat.formatDescription else {
            return .zero
        }
        
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
        return CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
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
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            ApplicationLogger.shared.Error(error!.localizedDescription)
            returnImage(nil)
            return
        }
        let imageData = photo.fileDataRepresentation()
        if let data = imageData, let originalImage = UIImage(data: data), let previewLayer = previewLayer, let croppedImage = originalImage.cropCameraImage(previewLayer: previewLayer) {
            returnImage(croppedImage.jpegData(compressionQuality: 0.5))
        } else {
            let resizedImageData = imageData?.resizeImage(maxResolution: 2000, compression: 0.5)
            returnImage(resizedImageData)
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    private func getImageOrientation() -> UIInterfaceOrientation {
        switch deviceOrientation {
        case .portrait:           return .landscapeLeft
        //case .portraitUpsideDown: return .landscapeLeft
        case .landscapeLeft:      return .portrait
        case .landscapeRight:     return .portraitUpsideDown
        default: return .portrait
        }
    }
    
    private func getCroppedTargetFrame(width: Int, height: Int) -> CGRect {
        let gravity = Defaults.videoGravity
        switch gravity {
        case .resizeAspect:
            let imageRect = CGRect(x: 0, y: 0, width: width, height: height)
            let croppedTargetFrame = imageRect.flip().rectThatFitsRect(targetFrame)
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
            let layerRect: CGRect
            if isPortrait() {
                layerRect = imageRect.rectThatFitsRect(targetFrame)
            } else {
                layerRect = imageRect.rectThatFitsRect(targetFrame)
            }
            
            let metadataRect = previewLayer!.metadataOutputRectConverted(fromLayerRect: layerRect)
            let cropRect = metadataRect.applying(CGAffineTransform(scaleX: CGFloat(width), y: CGFloat(height)))
            return cropRect
            
        case .resizeAspectFill:
            let layerRect = targetFrame
            let metadataRect = previewLayer!.metadataOutputRectConverted(fromLayerRect: layerRect)
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
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard detectionRunning else { return }
        guard targetFrame.width > 0 else { return }
        
        // crop pixel data if necessary
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
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
            videoWriter.captureOutput(output, didOutput: sampleBuffer, from: connection)
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
        guard let previewLayer = previewLayer else {
            return
        }
        let commandsRect: CGRect
        if photoType.isDocument {
            if targetFrame == .zero {
                return
            }
            commandsRect = previewLayer.frame
        } else {
            commandsRect = previewLayer.frame //imageRect.rectThatFitsRect(previewLayer.frame)
        }
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
    
    private func isPortrait() -> Bool {
        switch UIDevice.current.orientation {
        case .portrait:
            return true
        default:
            return false
        }
    }
}

// MARK: - VideoWriterDelegate
extension CameraViewController: VideoWriterDelegate {
    public func didTakeVideo(_ videoAsset: AVURLAsset) {
        delegate?.didTakeVideo(videoAsset, type: self.photoType)
    }
}
