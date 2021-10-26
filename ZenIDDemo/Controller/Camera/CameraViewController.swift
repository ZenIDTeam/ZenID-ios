
import AVFoundation
import CoreGraphics
import RecogLib_iOS
import UIKit


class CameraViewController: UIViewController {
    weak var delegate: CameraViewControllerDelegate?
    
    // This enables / disables additional debug visualisation hints from the ZenID framework
    public var showVisualisationDebugInfo: Bool = false {
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
            instructionView.isHidden = !showInstructionView
        }
    }
    
    public var photosCount: Int {
        didSet {
            saveTrigger.isHidden = photosCount == 0
        }
    }
    
    private let saveTrigger = Buttons.Camera.saveStack
    private let cameraTrigger = Buttons.Camera.trigger
    private var statusButton = Buttons.Camera.status
    private let instructionView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        let subView = UIView(frame: stack.bounds)
        subView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 8
        stack.insertSubview(subView, at: 0)
        return stack
    }()

    private let topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .messageLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private var controlView = UIView()
    private let cameraView = UIView()
    private let messageView = MessagesView()
    private var overlay: CameraOverlayView?
    private var targetFrame: CGRect = .zero
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var drawLayer: DrawingLayer?
    
    private var photoType: PhotoType
    private var documentType: DocumentType
    private var country: Country
    private var faceMode: FaceMode?

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    private var captureDevicePosition: AVCaptureDevice.Position = .back
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    private var cameraVideoOutput: AVCaptureVideoDataOutput!
    private var videoWriter: VideoWriter!
    
    private var deviceOrientation = UIInterfaceOrientation.landscapeLeft
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
    private var previousResult: DocumentResult?
    private var previousHologramResult: HologramState?
    private var previousFaceLivenessResult: FaceLivenessState?
    private var previousSelfieResult: SelfieState?
    
    private var supportChangedOrientation: Bool {
        return photoType != .face && photoType != .hologram
    }
    
    private var isFaceDetection: Bool {
        return photoType == .face
    }
    
    private var documents: [Document]
    private var documentSettings: DocumentVerifierSettings?
    
    init(photoType: PhotoType, documentType: DocumentType, country: Country, faceMode: FaceMode) {
        self.photoType = photoType
        self.documentType = documentType
        self.country = country
        self.faceMode = faceMode
        self.photosCount = 0
        self.documents = []
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        setupView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        saveTrigger.setTitle("\("btn-save".localized) (\(photosCount))", for: .normal)
        configureOverlay()
        DispatchQueue.main.async { [weak self] in
            self?.orientationChanged()
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previousResult = nil
        previousHologramResult = nil
        previousFaceLivenessResult = nil
        previousSelfieResult = nil
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
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // set previewLayer frame
        if let previewLayer = previewLayer {
            previewLayer.frame = cameraView.bounds
        }

        self.targetFrame = overlay?.frame ?? .zero
    }
    
    deinit {
        captureSession.stopRunning()
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    public func configureController(type: DocumentType, photoType: PhotoType, country: Country, faceMode: FaceMode?, photosCount: Int = 0, documents: [Document], documentSettings: DocumentVerifierSettings) {
        self.detectionRunning = false
        self.photoType = photoType
        self.documentType = type
        self.country = country
        self.faceMode = faceMode
        self.documents = documents
        self.captureDevicePosition = isFaceDetection ? .front : .back
        self.rotateInstructionView()
        
        self.title = type.title
        self.topLabel.text = photoType.message
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
            
        case .hologram:
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
            break
        default:
            // Reset verifier
            self.documentVerifier.reset()
            
            // This will setup document verifier to stop detect holograms
            self.documentVerifier.endHologramVerification()
            
            if type == .unspecifiedDocument {
                resetDocumentVerifier()
            }
            else
            {
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
        
        if type == .filter {
            documentVerifier.documentsInput = .init(documents: documents)
        }

        documentVerifier.showDebugInfo = showVisualisationDebugInfo
        faceLivenessVerifier.showDebugInfo = showVisualisationDebugInfo
        selfieVerifier.showDebugInfo = showVisualisationDebugInfo
        
        // This hides visualisation hints, overlay and instructions for generic documents
        if type == .otherDocument {
            self.showStaticOverlay = false
            self.showVisualisation = false
            self.showInstructionView = false
        } else {
            self.showStaticOverlay = true
            self.showVisualisation = true
            self.showInstructionView = true
        }
        
        // Control view
        self.setupControlView()
        
        // Start detection
        self.detectionRunning = true
        
        setNilAllPreviousResults()
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
        previousHologramResult = nil
        previousFaceLivenessResult = nil
        previousSelfieResult = nil
    }
    
    public func showErrorMessage(_ message: String) {
        messageView.showMessage(type: .error(message: message))
    }

    public func showSuccess() {
        messageView.showMessage(type: .success)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.black

        // Camera view
        view.addSubview(cameraView)
        cameraView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        
        // Control view
        setupControlView()

        // Message view
        cameraView.addSubview(messageView)
        messageView.anchor(top: cameraView.safeAreaLayoutGuide.topAnchor, left: cameraView.leftAnchor, bottom: nil, right: cameraView.rightAnchor)

        // Top label wrapper
        let topLabelWrapper = UIView()
        topLabelWrapper.backgroundColor = .clear
        topLabelWrapper.addSubview(topLabel)
        topLabel.anchor(top: topLabelWrapper.topAnchor, left: topLabelWrapper.leftAnchor, bottom: topLabelWrapper.bottomAnchor, right: topLabelWrapper.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)

        // Instructions view
        instructionView.addArrangedSubview(statusButton)
        instructionView.addArrangedSubview(topLabelWrapper)
        view.addSubview(instructionView)
        instructionView.centerX(to: cameraView)
        instructionView.centerY(to: cameraView)
    }
    
    private func setupControlView() {
        controlView.removeFromSuperview()
        controlView = UIView()
        if documentType == .otherDocument {
            view.addSubview(controlView)
            controlView.anchor(top: cameraView.bottomAnchor, left: view.leftAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor)
            
            // Trigger button
            controlView.addSubview(cameraTrigger)
            cameraTrigger.isHidden = false
            cameraTrigger.addTarget(self, action: #selector(capture), for: .touchUpInside)
            cameraTrigger.anchor(top: controlView.topAnchor, left: nil, bottom: controlView.bottomAnchor, right: nil, paddingTop: 10, paddingBottom: 10)
            cameraTrigger.centerX(to: controlView)
            cameraTrigger.centerY(to: controlView)

            // Save button
            controlView.addSubview(saveTrigger)
            saveTrigger.anchor(top: controlView.topAnchor, left: cameraTrigger.rightAnchor, bottom: controlView.bottomAnchor, right: controlView.rightAnchor)
            saveTrigger.addTarget(self, action: #selector(save), for: .touchUpInside)
        }
        else {
            view.addSubview(controlView)
            controlView.anchor(top: cameraView.bottomAnchor, left: view.leftAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor)
            controlView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            controlView.addSubview(cameraTrigger)
            cameraTrigger.translatesAutoresizingMaskIntoConstraints = false
            cameraTrigger.isHidden = true
        }
    }

    private func updateView(with result: DocumentResult?, buffer: CVPixelBuffer) {
        guard let unwrappedResult = result else {
            statusButton.setTitle("nil result", for: .normal)
            return
        }

        guard unwrappedResult.state == .Ok /*|| unwrappedResult.state == .Blurry*/, previousResult?.state != .Ok else {
            statusButton.setTitle("\(unwrappedResult.state.localizedDescription)", for: .normal)
            return
        }
        previousResult = unwrappedResult
        
        guard detectionRunning else { return }
        detectionRunning = false
        
        let unifiedResult = result == nil ? nil : UnifiedDocumentResultAdapter(result: result!)
        // return preview image
        returnImage(buffer, ImageFlip.fromLandScape, result: unifiedResult)
    }
    
    private func updateView(with result: HologramResult?, buffer: CVPixelBuffer) {
        guard let unwrappedResult = result else {
            statusButton.setTitle("nil result", for: .normal)
            return
        }
        
        guard unwrappedResult.hologramState == .Ok, previousHologramResult != .Ok else {
            statusButton.setTitle(String(describing: unwrappedResult.hologramState), for: .normal)
            return
        }
        previousHologramResult = unwrappedResult.hologramState
        
        guard detectionRunning else { return }
        detectionRunning = false
        
        // stop video recording
        videoWriter.stop()
    }
    
    private func updateView(with result: FaceLivenessResult?, buffer: CVPixelBuffer) {
        guard let unwrappedResult = result else {
            statusButton.setTitle("nil result", for: .normal)
            return
        }
        
        guard unwrappedResult.faceLivenessState == .Ok, previousFaceLivenessResult != .Ok else {
            statusButton.setTitle(String(describing: unwrappedResult.faceLivenessState), for: .normal)
            return
        }
        previousFaceLivenessResult = unwrappedResult.faceLivenessState
        
        guard detectionRunning else { return }
        detectionRunning = false
        
        let unifiedResult = result == nil ? nil : UnifiedFacelivenessResultAdapter(result: result!)
        // return preview image
        returnImage(buffer, ImageFlip.fromPortrait, result: unifiedResult)
    }
    
    private func updateView(with result: SelfieResult?, buffer: CVPixelBuffer) {
        guard let unwrappedResult = result else {
            statusButton.setTitle("nil result", for: .normal)
            return
        }
        
        guard unwrappedResult.selfieState == .Ok, previousSelfieResult != .Ok else {
            statusButton.setTitle(String(describing: unwrappedResult.selfieState), for: .normal)
            return
        }
        previousSelfieResult = unwrappedResult.selfieState
        
        guard detectionRunning else { return }
        detectionRunning = false
        
        let unifiedResult = result == nil ? nil : UnifiedSelfieResultAdapter(result: result!)
        // return preview image
        returnImage(buffer, ImageFlip.fromPortrait, result: unifiedResult)
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
    
    @objc private func orientationChanged() {
        switch UIDevice.current.orientation {
        case .portrait:           self.deviceOrientation = .portrait
        //case .portraitUpsideDown: self.deviceOrientation = .portraitUpsideDown
        case .portraitUpsideDown: return
        case .landscapeLeft:      self.deviceOrientation = .landscapeLeft
        case .landscapeRight:     self.deviceOrientation = .landscapeRight
        default: break;
        }
        
        drawLayer?.renderables = []
        rotateOverlay()
        rotateInstructionView()
    }
    
    @objc private func save() {
        delegate?.didFinishPDF()
    }
    
    private func returnImage(_ buffer: CVPixelBuffer, _ flipMethod: ImageFlip, result: UnifiedResult? = nil) {
        let image = UIImage(pixelBuffer: buffer)?.flip(flipMethod)
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
                self.previousResult = nil
                self.previousFaceLivenessResult = nil
                self.previousSelfieResult = nil
                self.previousHologramResult = nil
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
        
        // Configure layers
        if previewLayer == nil {
            self.configurePreviewLayer(session: self.captureSession)
        }
        self.configureDrawingLayer()
        self.configureOverlay()
        // Add message layer on top of preview layer to show messages over the image from camera
        self.cameraView.layer.addSublayer(self.messageView.layer)
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
    
    func configurePreviewLayer(session: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer!.videoGravity = Defaults.videoGravity
        previewLayer!.frame = cameraView.layer.bounds
        cameraView.layer.addSublayer(previewLayer!)
    }

    func configureDrawingLayer() {
        guard let previewLayer = previewLayer else { return }
        drawLayer?.removeFromSuperlayer()
        drawLayer = DrawingLayer()
        previewLayer.addSublayer(drawLayer!)
    }
    
    func configureOverlay() {
        self.overlay?.removeFromSuperview()
        self.overlay = CameraOverlayView(documentType: documentType, photoType: photoType, frame: cameraView.bounds)
        if let overlay = self.overlay {
            cameraView.addSubview(overlay)
            overlay.anchor(top: cameraView.topAnchor, left: cameraView.leftAnchor, bottom: cameraView.bottomAnchor, right: cameraView.rightAnchor)
            overlay.isHidden = !showStaticOverlay
            overlay.setupSafeArea(layoutGuide: view.safeAreaLayoutGuide)
            rotateOverlay()
        }
    }
    
    func rotateOverlay() {
        guard let overlay = self.overlay else { return }
        
        if !supportChangedOrientation {
            return
        }
        
        let gravity = Defaults.videoGravity
        switch gravity {
        case .resizeAspect:
            let resolution = getCurrentResolution()
            let imageRect = CGRect(x: 0, y: 0, width: resolution.width, height: resolution.height)
            let croppedTargetFrame = imageRect.flip().rectThatFitsRect(targetFrame)
            let layerRect = (supportChangedOrientation && isPortraitOrientation()) ?
                croppedTargetFrame.flip().rectThatFitsRect(croppedTargetFrame) :
                croppedTargetFrame;
            overlay.setupImage(flipped: isPortraitOrientation(), in: layerRect)
            
        case .resizeAspectFill:
            overlay.setupImage(flipped: isPortraitOrientation())
            
        default:
            overlay.setupImage(flipped: isPortraitOrientation())
        }
    }
    
    func rotateInstructionView() {
        if isFaceDetection {
            self.instructionView.transform = .identity
            return
        }
       
        if !supportChangedOrientation {
            self.instructionView.transform = CGAffineTransform(rotationAngle: .pi/2)
            return
        }
        
        let flipped = isPortraitOrientation()
        let mirrored = isUpsideDownOrientation()
        if flipped {
            self.instructionView.transform = mirrored ?
                CGAffineTransform(rotationAngle: .pi) :
                CGAffineTransform.identity
        } else {
            self.instructionView.transform = mirrored ?
                CGAffineTransform(rotationAngle: -.pi/2) :
                CGAffineTransform(rotationAngle: .pi/2)
        }
    }
    
    private func getCurrentResolution() -> CGSize {
        guard let formatDescription = captureDevice?.activeFormat.formatDescription else {
            return .zero
        }
        
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
        return CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
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
        switch self.deviceOrientation {
        case .portrait:           return .landscapeLeft
        //case .portraitUpsideDown: return .landscapeLeft
        case .landscapeLeft:      return .portrait
        case .landscapeRight:     return .portraitUpsideDown
        default: return .portrait
        }
    }
    
    private func isPortraitOrientation() -> Bool {
        switch self.deviceOrientation {
        case .portrait:  return true
        //case .portraitUpsideDown: return true
        default: return false
        }
    }
    
    private func isUpsideDownOrientation() -> Bool {
        switch self.deviceOrientation {
        //case .portraitUpsideDown: return true
        case .landscapeRight: return true
        default: return false
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
            let layerRect = imageRect.flip().rectThatFitsRect(targetFrame)
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
        let imageRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight).flip()
        
        // torch for holograms
        self.setTorch(on: photoType == .hologram)

        switch photoType {
        case .face:
            switch self.faceMode {
            case .faceLiveness:
                if let result = faceLivenessVerifier.verifyImage(imageBuffer: croppedBuffer)
                {
                    DispatchQueue.main.async { [unowned self] in
                        self.updateView(with: result, buffer: croppedBuffer)
                    }

                    if !showVisualisation {
                        return
                    }
                    
                    guard let previewLayer = previewLayer else { break; }
                    let commandsRect = imageRect.rectThatFitsRect(previewLayer.frame);
                    if let renderCommands = faceLivenessVerifier.getRenderCommands(canvasWidth: Int(commandsRect.width),
                                                                                  canvasHeight: Int(commandsRect.height)) {
                        if let drawLayer = drawLayer {
                            let renderables = RenderableFactory.createRenderables(commands: renderCommands)
                            drawLayer.frame = commandsRect
                            drawLayer.renderables = renderables
                        }
                    }
                }
            case .selfie:
                if let result = selfieVerifier.verifyImage(imageBuffer: croppedBuffer)
                {
                    DispatchQueue.main.async { [unowned self] in
                        self.updateView(with: result, buffer: croppedBuffer)
                    }

                    if !showVisualisation {
                        return
                    }
                    
                    // Get render commands
                    guard let previewLayer = previewLayer else { break; }
                    let commandsRect = imageRect.rectThatFitsRect(previewLayer.frame);
                    if let renderCommands = selfieVerifier.getRenderCommands(canvasWidth: Int(commandsRect.width),
                                                                             canvasHeight: Int(commandsRect.height)) {
                        let renderables = RenderableFactory.createRenderables(commands: renderCommands)
                        if let drawLayer = drawLayer {
                            drawLayer.frame = commandsRect
                            drawLayer.renderables = renderables
                        }
                    }
                }
            case .none:
                break
            }
            
        case .hologram:
            if let videoWriter = self.videoWriter {
                if videoWriter.isRecording {
                    videoWriter.captureOutput(output, didOutput: sampleBuffer, from: connection)
                    if let result = documentVerifier.verifyHologramImage(imageBuffer: croppedBuffer)
                    {
                        DispatchQueue.main.async { [unowned self] in
                            self.updateView(with: result, buffer: croppedBuffer)
                        }
                    }
                }
            }
            
        default:
            if let result = documentVerifier.verifyImage(imageBuffer: croppedBuffer, orientation: getImageOrientation())
            {
                DispatchQueue.main.async { [unowned self] in
                    self.updateView(with: result, buffer: croppedBuffer)
                }

                if !showVisualisation {
                    return
                }
                
                // Get render commands
                if targetFrame == .zero { break; }
                let flipped = !isPortraitOrientation()
                let croppedPreview = getCroppedTargetFrame(width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
                let commandsRect = flipped ? croppedPreview.flip() : croppedPreview
                if let renderCommands = documentVerifier.getRenderCommands(canvasWidth: Int(commandsRect.width),
                                                                           canvasHeight: Int(commandsRect.height)) {
                    let renderables = RenderableFactory.createRenderables(commands: renderCommands)
                    
                    if let drawLayer = drawLayer {
                        let mirrored = isUpsideDownOrientation()
                        let transform = flipped ?
                            (mirrored ? CGAffineTransform(rotationAngle: -.pi / 2) : CGAffineTransform(rotationAngle: .pi / 2)) :
                            (mirrored ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity)
                        
                        drawLayer.frame = flipped ? commandsRect.flip() : commandsRect
                        drawLayer.setAffineTransform(transform)
                        drawLayer.renderables = renderables
                    }
                }
            }
        }
    }
    
}

// MARK: - VideoWriterDelegate
extension CameraViewController: VideoWriterDelegate {
    public func didTakeVideo(_ videoAsset: AVURLAsset) {
        delegate?.didTakeVideo(videoAsset, type: self.photoType)
    }
}
