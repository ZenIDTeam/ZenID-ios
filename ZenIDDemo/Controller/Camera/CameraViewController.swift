//
//  CameraViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import AVFoundation
import CoreGraphics
import RecogLib_iOS
import UIKit

public class CameraViewController: UIViewController {
    public weak var delegate: CameraViewControllerDelegate?
    
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
    private var faceMode: FaceMode

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    private var captureDevicePosition: AVCaptureDevice.Position = .back
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    private var cameraVideoOutput: AVCaptureVideoDataOutput!
    private var videoWriter: VideoWriter!
    
    private var documentVerifier: DocumentVerifier = DocumentVerifier(
                                                            role: RecogLib_iOS.DocumentRole.Idc,
                                                            country: RecogLib_iOS.Country.Cz,
                                                            page: RecogLib_iOS.PageCode.Front,
                                                            language: LanguageHelper.language)
    private var faceLivenessVerifier: FaceLivenessVerifier = FaceLivenessVerifier(language: LanguageHelper.language)
    private var selfieVerifier: SelfieVerifier = SelfieVerifier(language: LanguageHelper.language)
    
    private var detectionRunning = false;
    private var previousResult: DocumentState?
    private var previousHologramResult: HologramState?
    private var previousFaceLivenessResult: FaceLivenessState?
    private var previousSelfieResult: SelfieState?
    
    init(photoType: PhotoType, documentType: DocumentType, country: Country, faceMode: FaceMode) {
        self.photoType = photoType
        self.documentType = documentType
        self.country = country
        self.faceMode = faceMode
        self.photosCount = 0
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        saveTrigger.setTitle("\("btn-save".localized) (\(photosCount))", for: .normal)
        configureOverlay()
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
        navigationController?.navigationBar.isHidden = true
        
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
            
            // set drawLayer frame
            if let drawLayer = drawLayer {
                let flipped = photoType != .face
                drawLayer.frame = flipped
                    ? previewLayer.bounds.flip()
                    : previewLayer.bounds
                if flipped {
                    drawLayer.position = CGPoint(x: drawLayer.frame.height, y: 0)
                    drawLayer.anchorPoint = CGPoint(x: 0, y: 0)
                    let rotation = CGAffineTransform(rotationAngle: .pi / 2)
                    drawLayer.setAffineTransform(rotation)
                }
            }
        }

        self.targetFrame = overlay?.frame ?? .zero
    }
    
    deinit {
        captureSession.stopRunning()
    }

    public func configureController(type: DocumentType, photoType: PhotoType, country: Country, faceMode: FaceMode, photosCount: Int = 0) {
        self.detectionRunning = false
        self.photoType = photoType
        self.documentType = type
        self.country = country
        self.faceMode = faceMode
        self.captureDevicePosition = photoType == .face ? .front : .back
        self.instructionView.transform = photoType == .face ? .identity : CGAffineTransform(rotationAngle: CGFloat.pi/2)
        
        self.title = type.title
        self.topLabel.text = photoType.message
        self.photosCount = photosCount
        self.previousResult = nil
        self.previousHologramResult = nil
        self.previousFaceLivenessResult = nil
        self.previousSelfieResult = nil

        // Start video capture session
        self.startSession()
        
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
            break
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

        guard unwrappedResult.state == .Ok, previousResult != .Ok else {
            statusButton.setTitle("\(unwrappedResult.state.localizedDescription)", for: .normal)
            return
        }
        previousResult = unwrappedResult.state
        
        guard detectionRunning else { return }
        detectionRunning = false
        
        // return preview image
        returnImage(buffer, ImageFlip.fromLandScape)
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
        
        // return preview image
        returnImage(buffer, ImageFlip.fromPortrait)
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
        
        // return preview image
        returnImage(buffer, ImageFlip.fromPortrait)
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
    
    private func returnImage(_ buffer: CVPixelBuffer, _ flipMethod: ImageFlip) {
        // Get targetting margins
        let width = CVPixelBufferGetWidth(buffer)
        let height = CVPixelBufferGetHeight(buffer)
        let cropRect = getCropRect(width: width, height: height, targetRect: targetFrame)
        let image = UIImage(pixelBuffer: buffer, crop: cropRect)?.flip(flipMethod)
        let data = image?.jpegData(compressionQuality: 0.5)
        returnImage(data)
    }
    
    private func returnImage(_ data: Data?) {
        if let data = data, let image = UIImage(data: data) {
            let preview = PreviewViewController(title:title ?? "", image: image)
            preview.saveAction = { [unowned self] in
                self.delegate?.didTakePhoto(data, type: self.photoType)
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
            delegate?.didTakePhoto(nil, type: photoType)
            navigationController?.popViewController(animated: true)
        }
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
        previewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
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
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            returnImage(nil)
            debugPrint("Error capturing image")
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
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard detectionRunning else { return }
        guard targetFrame.width > 0 else { return }
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        self.setTorch(on: photoType == .hologram)
        
        switch photoType {
        case .face:
            switch self.faceMode {
            case .faceLiveness:
                if let result = faceLivenessVerifier.verifyImage(imageBuffer: pixelBuffer)
                {
                    DispatchQueue.main.async { [unowned self] in
                        self.updateView(with: result, buffer: pixelBuffer)
                    }

                    if !showVisualisation {
                        return
                    }

                    // Get render commands
                    let width = Int(self.previewLayer?.frame.width ?? 0)
                    let height = Int(self.previewLayer?.frame.height ?? 0)
                    if let renderCommands = faceLivenessVerifier.getRenderCommands(canvasWidth: width,
                                                                                   canvasHeight: height) {
                        let renderables = RenderableFactory.createRenderables(commands: renderCommands)
                        self.drawLayer?.renderables = renderables
                    }
                }
            case .selfie:
                if let result = selfieVerifier.verifyImage(imageBuffer: pixelBuffer)
                {
                    DispatchQueue.main.async { [unowned self] in
                        self.updateView(with: result, buffer: pixelBuffer)
                    }

                    if !showVisualisation {
                        return
                    }

                    // Get render commands
                    let width = Int(self.previewLayer?.frame.width ?? 0)
                    let height = Int(self.previewLayer?.frame.height ?? 0)
                    if let renderCommands = selfieVerifier.getRenderCommands(canvasWidth: width,
                                                                             canvasHeight: height) {
                        let renderables = RenderableFactory.createRenderables(commands: renderCommands)
                        self.drawLayer?.renderables = renderables
                    }
                }
            }
            
        case .hologram:
            if let videoWriter = self.videoWriter {
                if videoWriter.isRecording {
                    videoWriter.captureOutput(output, didOutput: sampleBuffer, from: connection)
                    if let result = documentVerifier.verifyHologramImage(imageBuffer: pixelBuffer)
                    {
                        DispatchQueue.main.async { [unowned self] in
                            self.updateView(with: result, buffer: pixelBuffer)
                        }
                    }
                }
            }
            
        default:
            if let result = documentVerifier.verifyImage(imageBuffer: pixelBuffer)
            {
                DispatchQueue.main.async { [unowned self] in
                    self.updateView(with: result, buffer: pixelBuffer)
                }

                if !showVisualisation {
                    return
                }
                
                // Get render commands
                let width = Int(self.previewLayer?.frame.width ?? 0)
                let height = Int(self.previewLayer?.frame.height ?? 0)
                if let renderCommands = documentVerifier.getRenderCommands(canvasWidth: height,
                                                                   canvasHeight: width) {
                    let renderables = RenderableFactory.createRenderables(commands: renderCommands)
                    self.drawLayer?.renderables = renderables
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

// MARK: - Private
extension CameraViewController {
    private func getCropRect(width: Int, height: Int, targetRect: CGRect) -> CGRect {
        guard let previewLayer = previewLayer else { return .zero }
        
        let cropRect: CGRect = (previewLayer.metadataOutputRectConverted(fromLayerRect: targetRect))
            .applying(CGAffineTransform(scaleX: CGFloat(width), y: CGFloat(height)))
        
        return cropRect
    }
    
    private func setTorch(on: Bool) {
        guard let device = self.captureDevice else { return }
        Torch.shared.ensureMode(for: device, on: on)
    }
}
