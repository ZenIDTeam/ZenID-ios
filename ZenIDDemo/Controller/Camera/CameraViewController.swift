import AVFoundation
import CoreGraphics
import RecogLib_iOS
import UIKit

class CameraViewController: UIViewController {
    weak var delegate: CameraViewControllerDelegate?

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .all
    }

    override var shouldAutorotate: Bool {
        return true
    }

    private let messageView = MessagesView()
    private var contentView: CameraView {
        view as! CameraView
    }

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
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = CameraView()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.allButUpsideDown, andRotateTo: UIDevice.current.orientation)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startControllers()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopControllers()
    }

    deinit {
        stopControllers()
    }

    public func stopControllers() {
        documentController?.stop()
        facelivenessController?.stop()
        selfieController?.stop()
    }

    public func startControllers() {
        documentController?.start()
        facelivenessController?.start()
        selfieController?.start()
    }

    public func configureController(type: DocumentType, photoType: PhotoType, country: Country, faceMode: FaceMode?, documents: [Document], documentSettings: DocumentVerifierSettings, facelivenessSettings: FaceLivenessVerifierSettings, config: Config) {
        self.photoType = photoType
        documentType = type
        self.faceMode = faceMode
        dataType = dataType(of: documentType, photoType: photoType, isLivenessVideo: config.isLivenessVideo)

        title = type.title

        startSession()

        documentController = nil
        facelivenessController = nil
        selfieController = nil

        documentControllerConfig = nil
        facelivenessControllerConfig = nil
        selfieControllerConfig = nil

        switch photoType {
        case .front, .back:
            setupDocumentController()
            documentControllerConfig = .init(
                showVisualisation: true,
                showHelperVisualisation: true,
                showDebugVisualisation: config.isDebugEnabled,
                dataType: dataType,
                role: RecoglibMapper.documentRole(from: type),
                country: country,
                page: photoType == .front ? .F : .B,
                code: nil,
                documents: type == .filter ? documents : nil,
                settings: documentSettings
            )
            updateDocumentController()
        case .face:
            guard let faceMode else { return }
            switch faceMode {
            case .faceLiveness:
                setupFacelivenessController()
                facelivenessControllerConfig = .init(
                    showVisualisation: true,
                    showHelperVisualisation: true,
                    showDebugVisualisation: config.isDebugEnabled,
                    dataType: dataType,
                    settings: facelivenessSettings
                )
                updateFacelivenessController()
            case .selfie:
                setupSelfieController()
                selfieControllerConfig = .init(
                    showVisualisation: true,
                    showHelperVisualisation: true,
                    showDebugVisualisation: config.isDebugEnabled,
                    dataType: dataType
                )
                updateSelfieController()
            }
        }

        contentView.layer.addSublayer(messageView.layer)
    }

    private func dataType(of documentType: DocumentType, photoType: PhotoType, isLivenessVideo: Bool) -> DataType {
        if documentType == .documentVideo || photoType == .face && isLivenessVideo {
            return .video
        }
        return .picture
    }

    public func showErrorMessage(_ message: String) {
        messageView.showMessage(type: .error(message: message))
    }

    public func showSuccess() {
        messageView.showMessage(type: .success)
    }

    private func setupView() {
        view.backgroundColor = UIColor.black

        contentView.addSubview(messageView)
        messageView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor)
    }

    private func returnImage(_ buffer: CVPixelBuffer, result: UnifiedResult? = nil) {
        let image = UIImage(pixelBuffer: buffer)
        let data = image?.jpegData(compressionQuality: 0.5)
        returnImage(data, result)
    }

    private func returnImage(_ data: Data?, _ result: UnifiedResult? = nil) {
        if let signatureImageData = result?.signature?.image, let signatureImage = UIImage(data: signatureImageData) {
            let preview = PreviewViewController(title: title ?? "", image: signatureImage)
            preview.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            preview.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

            preview.saveAction = { [unowned self] in
                self.delegate?.didTakePhoto(signatureImageData, type: self.photoType, result: result)
            }
            preview.dismissAction = { [unowned self] in
                if self.photoType.isDocument {
                    self.updateDocumentController()
                } else {
                    self.updateSelfieController()
                }
            }

            present(preview, animated: true, completion: nil)
        } else {
            delegate?.didTakePhoto(nil, type: photoType, result: nil)
            navigationController?.popViewController(animated: true)
        }
    }
}

// Controllers
extension CameraViewController {
    func setupDocumentController() {
        if documentController != nil { return }
        documentController = DocumentController(camera: camera, view: contentView, modelsUrl: URL.modelsDocuments)
        documentController?.delegate = self
    }

    func setupFacelivenessController() {
        if facelivenessController != nil { return }
        facelivenessController = FacelivenessController(camera: camera, view: contentView, modelsUrl: URL.modelsFolder.appendingPathComponent("face"))
        facelivenessController?.delegate = self
    }

    func setupSelfieController() {
        if selfieController != nil { return }
        selfieController = SelfieController(camera: camera, view: contentView, modelsUrl: URL.modelsFolder.appendingPathComponent("face"))
        selfieController?.delegate = self
    }

    func updateDocumentController() {
        guard let configuration = documentControllerConfig else { return }
        do {
            try documentController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }

    func updateFacelivenessController() {
        guard let configuration = facelivenessControllerConfig else { return }
        do {
            try facelivenessController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }

    func updateSelfieController() {
        guard let configuration = selfieControllerConfig else { return }
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

    func controller(_ controller: DocumentController, didUpdate result: DocumentResult) {
        debugPrint(result)
    }
}

extension CameraViewController: FacelivenessControllerDelegate {
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult) {
        if let auxiliaryInfo = controller.getAuxiliaryImages() {
            saveAuxiliaryImagesToLibrary(info: auxiliaryInfo)
        }
        returnImage(nil, UnifiedFacelivenessResultAdapter(result: result))
    }

    func controller(_ controller: FacelivenessController, didRecord videoURL: URL) {
        delegate?.didTakeVideo(videoURL, type: photoType)
    }

    func controller(_ controller: FacelivenessController, didUpdate result: FaceLivenessResult) {
        debugPrint(result)
    }

    private func saveAuxiliaryImagesToLibrary(info: FaceLivenessAuxiliaryInfo?) {
        for image in info?.images ?? [] {
            guard let image = UIImage(data: image) else {
                continue
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}

extension CameraViewController: SelfieControllerDelegate {
    func controller(_ controller: SelfieController, didScan result: SelfieResult) {
        returnImage(nil, UnifiedSelfieResultAdapter(result: result))
    }

    func controller(_ controller: SelfieController, didRecord videoURL: URL) {
        delegate?.didTakeVideo(videoURL, type: photoType)
    }

    func controller(_ controller: SelfieController, didUpdate result: SelfieResult) {
        debugPrint(result)
    }
}

// MARK: - Methods for AV session

private extension CameraViewController {
    func startSession() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized, .notDetermined:
            getAccessToCamera()
        default:
            returnImage(nil)
        }
    }

    func getAccessToCamera() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            DispatchQueue.main.async { [unowned self] in
                if !granted {
                    self.returnImage(nil)
                }
            }
        })
    }
}
