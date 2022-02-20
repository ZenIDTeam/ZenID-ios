import UIKit
import RecogLib_iOS

final class MyViewController: UIViewController {
    private var documentController: DocumentController?
    private var selfieController: SelfieController?
    private var facelivenessController: FacelivenessController?
    private var camera: Camera?
    private var cameraView: CameraView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDocumentController()
        //setupSelfieController()
        //setupFacelivenessController()
    }
    
    func setupDocumentController() {
        camera = Camera()
        cameraView = CameraView()
        documentController = DocumentController(camera: camera!, view: cameraView!, modelsUrl: URL.modelsDocuments)
        documentController?.delegate = self
        
        cameraView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cameraView!)
        self.view.leftAnchor.constraint(equalTo: cameraView!.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: cameraView!.rightAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: cameraView!.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: cameraView!.bottomAnchor).isActive = true
        
        do {
            let configuration = DocumentControllerConfiguration(
                showVisualisation: true,
                showDebugVisualisation: false,
                dataType: .picture,
                role: .Idc,
                country: .Cz,
                page: .Front,
                code: nil,
                documents: nil,
                settings: nil
            )
            try documentController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
    
    func setupSelfieController() {
        camera = Camera()
        cameraView = CameraView()
        let selfieUrl = URL.modelsFolder.appendingPathComponent("face")
        selfieController = SelfieController(camera: camera!, view: cameraView!, modelsUrl: selfieUrl)
        selfieController?.delegate = self
        
        cameraView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cameraView!)
        self.view.leftAnchor.constraint(equalTo: cameraView!.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: cameraView!.rightAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: cameraView!.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: cameraView!.bottomAnchor).isActive = true
        
        do {
            let configuration = SelfieControllerConfiguration(
                showVisualisation: true,
                showDebugVisualisation: false,
                dataType: .picture
            )
            try selfieController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
    
    func setupFacelivenessController() {
        camera = Camera()
        cameraView = CameraView()
        let facelivenessUrl = URL.modelsFolder.appendingPathComponent("face")
        facelivenessController = FacelivenessController(camera: camera!, view: cameraView!, modelsUrl: facelivenessUrl)
        facelivenessController?.delegate = self
        
        cameraView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cameraView!)
        self.view.leftAnchor.constraint(equalTo: cameraView!.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: cameraView!.rightAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: cameraView!.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: cameraView!.bottomAnchor).isActive = true
        
        do {
            let configuration = FacelivenessControllerConfiguration(
                showVisualisation: true,
                showDebugVisualisation: false,
                dataType: .picture,
                isLegacy: false
            )
            try facelivenessController?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        documentController?.start()
        selfieController?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        documentController?.stop()
        selfieController?.stop()
    }
}

extension MyViewController: DocumentControllerDelegate {
    func controller(_ controller: DocumentController, didScan result: DocumentResult) {
        if let signatureImageData = result.signature?.image, let signatureImage = UIImage(data: signatureImageData) {
            let preview = PreviewViewController(title:title ?? "", image: signatureImage)
            preview.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            preview.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            preview.saveAction = { [unowned self] in
                
            }
            preview.dismissAction = { [unowned self] in
                
            }

            present(preview, animated: true, completion: nil)
        }
    }
    
    func controller(_ controller: DocumentController, didRecord videoURL: URL) {
        debugPrint(videoURL)
    }
}

extension MyViewController: SelfieControllerDelegate {
    func controller(_ controller: SelfieController, didScan result: SelfieResult) {
        if let signatureImageData = result.signature?.image, let signatureImage = UIImage(data: signatureImageData) {
            let preview = PreviewViewController(title:title ?? "", image: signatureImage)
            preview.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            preview.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            preview.saveAction = { [unowned self] in
                
            }
            preview.dismissAction = { [unowned self] in
                
            }

            present(preview, animated: true, completion: nil)
        }
    }
    
    func controller(_ controller: SelfieController, didRecord videoURL: URL) {
        debugPrint(videoURL)
    }
}

extension MyViewController: FacelivenessControllerDelegate {
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult) {
        if let signatureImageData = result.signature?.image, let signatureImage = UIImage(data: signatureImageData) {
            let preview = PreviewViewController(title:title ?? "", image: signatureImage)
            preview.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            preview.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            preview.saveAction = { [unowned self] in
                
            }
            preview.dismissAction = { [unowned self] in
                
            }

            present(preview, animated: true, completion: nil)
        }
    }
    
    func controller(_ controller: FacelivenessController, didRecord videoURL: URL) {
        debugPrint(videoURL)
    }
}
