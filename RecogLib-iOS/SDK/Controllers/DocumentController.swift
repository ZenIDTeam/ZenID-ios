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
    public let page: RecogLib_iOS.PageCodes?
    public let code: RecogLib_iOS.DocumentCodes?
    public let documents: [Document]?
    public let settings: DocumentVerifierSettings?

    public init(showVisualisation: Bool, showHelperVisualisation: Bool, showDebugVisualisation: Bool, dataType: DataType, role: RecogLib_iOS.DocumentRole?, country: RecogLib_iOS.Country?, page: RecogLib_iOS.PageCodes?, code: RecogLib_iOS.DocumentCodes?, documents: [Document]?, settings: DocumentVerifierSettings?) {
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
        state == .Ok || hologramState == .Ok || state == .Nfc
    }

    public var description: String {
        state.localizedDescription
    }
}

public protocol DocumentControllerDelegate: AnyObject {
    func controller(_ controller: DocumentController, didReadMrz result: DocumentResult, mrzCode: String)
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

    #if targetEnvironment(simulator)
        private var debugButton: UIButton = {
            var b = UIButton()
            b.layer.cornerRadius = 6
            b.backgroundColor = .gray
            b.setTitle("scan front ID", for: .normal)
            b.accessibilityIdentifier = "id-front"
            return b
        }()

        private var debugButtonBack: UIButton = {
            var b = UIButton()
            b.layer.cornerRadius = 6
            b.backgroundColor = .gray
            b.setTitle("scan back ID", for: .normal)
            b.accessibilityIdentifier = "id-back"
            return b
        }()

        @objc func didTapDebugButton(sender: UIButton) {
            guard let id = sender.accessibilityIdentifier else { return }
            print("didTapDebugButton: \(id)")
            switch id {
            case "id-front":
                guard let image = UIImage(named: "vzor-id-front") else { return }
                guard let buffer = image.toCMSampleBuffer() else { return }
                isRunning = true
                targetFrame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                cameraDelegate(camera: camera, onOutput: buffer)

            case "id-back":
                guard let image = UIImage(named: "vzor-id-nfc-back") else { return }
                guard let buffer = image.toCMSampleBuffer() else { return }
                isRunning = true
                targetFrame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                cameraDelegate(camera: camera, onOutput: buffer)

            default:
                break
            }
        }

    #endif

    public init(camera: Camera, view: CameraView, modelsUrl: URL, mrzModelsUrl: URL?) {
        verifier = .init(
            role: RecogLib_iOS.DocumentRole.Idc,
            country: RecogLib_iOS.Country.Cz,
            page: RecogLib_iOS.PageCodes.F,
            code: nil,
            language: .English
        )
        super.init(camera: camera, view: view)

        #if targetEnvironment(simulator)
            debugButton.addTarget(self, action: #selector(didTapDebugButton(sender:)), for: .touchUpInside)
            debugButtonBack.addTarget(self, action: #selector(didTapDebugButton(sender:)), for: .touchUpInside)
        #endif

        loadModels(url: modelsUrl, mrzURL: mrzModelsUrl)
    }

    deinit {
        verifier.endHologramVerification()
        verifier.reset()
        resetDocumentVerifier()
    }

    public func configure(configuration: DocumentControllerConfiguration = .default) throws {
        verifier.reset()
        verifier.endHologramVerification()
        let oldConfig = config
        config = configuration

        view.topLabel.text = config.page == .B ? LocalizedString("msg-scan-back", comment: "") : LocalizedString("msg-scan-front", comment: "")

        // Enrico: For documents, we should leave the resolution and fps fields blanks until we have test results.
        // verifier.getRequiredResolution(), verifier.getRequiredFPS()

        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showHelperVisualisation,
            dataType: configuration.dataType,
            cameraType: .back,
            requestedResolution: 0,
            requestedFPS: 0,
            processType: .document
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
        if let code = previousResult?.code, config.page == .B {
            verifier.code = code
        }
        if let documents = config.documents {
            verifier.documentsInput = .init(documents: documents)
        }

        if config.dataType == .video {
            verifier.beginHologramVerification()
        }

        verifier.showDebugInfo = config.showDebugVisualisation

        try configure(configuration: baseConfig)

        #if targetEnvironment(simulator)
            if let overlay = view.overlay {
                overlay.addSubview(debugButton)
                debugButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
                debugButton.centerX(to: overlay)
                debugButton.anchor(top: overlay.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24)

                overlay.addSubview(debugButtonBack)
                debugButtonBack.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
                debugButtonBack.centerX(to: overlay)
                debugButtonBack.anchor(top: debugButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 24)
            }
        #endif
    }

    public func processNfcResult(nfcData: NfcData, status: NfcStatus) -> DocumentResult? {
        guard let jsonString = nfcData.encodeToJson() else {
            ApplicationLogger.shared.Debug("❌ Failed to create NfcData JSON string")
            return nil
        }

        ApplicationLogger.shared.Debug("JSON encoded NFC result:")
        ApplicationLogger.shared.Debug(jsonString)

        ApplicationLogger.shared.Debug("calling processNfc()")
        verifier.processNfc(jsonData: jsonString, status: status)

        guard let state = verifier.getState() else {
            ApplicationLogger.shared.Debug("❌ Failed to read verifier state.")
            return nil
        }
        guard let signedImage = verifier.getSignedImage() else {
            ApplicationLogger.shared.Debug("❌ Failed to get signed image data. Verifier state != OK ?")
            return nil
        }
        return DocumentResult(signature: signedImage, state: state)
    }

    public func skipNfcResult() -> DocumentResult? {
        ApplicationLogger.shared.Debug("calling skipNfcResult()")
        verifier.processNfc(jsonData: "", status: .USER_SKIPPED)

        guard let state = verifier.getState() else {
            ApplicationLogger.shared.Debug("❌ Failed to read verifier state.")
            return nil
        }
        guard let signedImage = verifier.getSignedImage() else {
            ApplicationLogger.shared.Debug("❌ Failed to get signed image data. Verifier state != OK ?")
            return nil
        }
        return DocumentResult(signature: signedImage, state: state)
    }
    
    public func getSignedImage() -> ImageSignature? {
        verifier.getSignedImage()
    }

    public func getSdkConfiguration() -> DocumentVerifierNfcValidatorConfig {
        verifier.getNfcValidatorConfig()
    }

    public func getDocumentResult(orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        verifier.getDocumentResult(orientation: orientation)
    }

    override func verify(pixelBuffer: CVPixelBuffer) -> DocumentResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer)
    }

    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }

    override func callDelegate(with result: DocumentResult) {
        if result.state == .Nfc, let mrzCode = verifier.getNfcKey() {
            delegate?.controller(self, didReadMrz: result, mrzCode: mrzCode)
        } else {
            delegate?.controller(self, didScan: result)
        }
    }

    override func callDelegate(with videoUrl: URL) {
        delegate?.controller(self, didRecord: videoUrl)
    }

    override func callUpdateDelegate(with result: DocumentResult) {
        delegate?.controller(self, didUpdate: result)
    }

    private func loadModels(url: URL, mrzURL: URL?) {
        verifier.loadModels(.init(url: url)!, mrzModelsPath: mrzURL)
    }

    private func resetDocumentVerifier() {
        verifier.documentsInput = nil
        verifier.documentRole = nil
        verifier.page = nil
        verifier.country = nil
        verifier.code = nil
    }
}
