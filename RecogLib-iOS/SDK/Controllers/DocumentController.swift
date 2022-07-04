import Foundation
import UIKit

public struct DocumentControllerConfiguration {
    public static let `default` = DocumentControllerConfiguration(
        showVisualisation: true,
        showHelperVisualisation: true,
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
    public let showHelperVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let page: RecogLib_iOS.PageCode?
    public let code: RecogLib_iOS.DocumentCode?
    public let documents: [Document]?
    public let settings: DocumentVerifierSettings?
    
    public init(showVisualisation: Bool, showHelperVisualisation: Bool, showDebugVisualisation: Bool, dataType: DataType, role: RecogLib_iOS.DocumentRole?, country: RecogLib_iOS.Country?, page: RecogLib_iOS.PageCode?, code: RecogLib_iOS.DocumentCode?, documents: [Document]?, settings: DocumentVerifierSettings?) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.dataType = dataType
        self.role = role
        self.country = country
        self.page = page
        self.code = code
        self.documents = documents
        self.settings = settings
    }
}

extension DocumentResult: ResultState {
    public var isOk: Bool {
        state == .Ok || hologremState == .ok
    }
    
    public var description: String {
        state.localizedDescription
    }
}

public protocol DocumentControllerDelegate: AnyObject {
    func controller(_ controller: DocumentController, didScan result: DocumentResult)
    func controller(_ controller: DocumentController, didRecord videoURL: URL)
    func controller(_ controller: DocumentController, didUpdate result: DocumentResult)
}

public protocol DocumentControllerAbstraction {
    var delegate: DocumentControllerDelegate? { get set }
    
    func configure(configuration: DocumentControllerConfiguration) throws
}

public final class DocumentController: BaseController<DocumentResult>, DocumentControllerAbstraction {
    public weak var delegate: DocumentControllerDelegate?
    
    override var overlayImageName: String {
        if config.role == .Pas {
            return "targettingRectPas"
        }
        return "targettingRect"
    }
    
    private let verifier: DocumentVerifier
    
    private var config = DocumentControllerConfiguration.default
    
    public init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(
            role: RecogLib_iOS.DocumentRole.Idc,
            country: RecogLib_iOS.Country.Cz,
            page: RecogLib_iOS.PageCode.Front,
            code: nil,
            language: .English
        )
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    deinit {
        verifier.endHologramVerification()
    }
    
    public func configure(configuration: DocumentControllerConfiguration = .default) throws {
        verifier.reset()
        verifier.endHologramVerification()
        let oldConfig = self.config
        config = configuration
        
        view.topLabel.text = config.page == .Back ? LocalizedString("msg-scan-back", comment: "") : LocalizedString("msg-scan-front", comment: "")
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showHelperVisualisation,
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
    
    override func callUpdateDelegate(with result: DocumentResult) {
        delegate?.controller(self, didUpdate: result)
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
