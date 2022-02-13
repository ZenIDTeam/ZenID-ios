import UIKit
import RecogLib_iOS

final class MyViewController: UIViewController {
    private var controller: DocumentController?
    private var camera: Camera?
    private var cameraView: CameraView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera = Camera()
        cameraView = CameraView()
        controller = DocumentController(camera: camera!, view: cameraView!, modelsUrl: URL.modelsDocuments)
        controller?.delegate = self
        
        cameraView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cameraView!)
        self.view.leftAnchor.constraint(equalTo: cameraView!.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: cameraView!.rightAnchor).isActive = true
        self.view.topAnchor.constraint(equalTo: cameraView!.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: cameraView!.bottomAnchor).isActive = true
        
        do {
            let configuration = ControllerConfiguration(
                showVisualisation: true,
                dataType: .picture,
                role: .Idc,
                country: .Cz,
                page: .Front,
                code: nil,
                documents: nil,
                settings: nil
            )
            try controller?.configure(configuration: configuration)
        } catch {
            debugPrint(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        controller?.stop()
    }
}

extension MyViewController: DocumentControllerDelegate {
    func documentController(controller: DocumentController, didScan result: DocumentResult) {
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
    
    func documentController(controller: DocumentController, didRecord videoURL: URL) {
        
    }
}
