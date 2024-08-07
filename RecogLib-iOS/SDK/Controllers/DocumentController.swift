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
        settings: nil)

    public let showVisualisation: Bool
    
    public let showHelperVisualisation: Bool
    
    public let showDebugVisualisation: Bool
    
    public let showTextInstructions: Bool
    
    public let dataType: DataType
    
    public let role: RecogLib_iOS.DocumentRole?
    
    public let country: RecogLib_iOS.Country?
    
    public let page: RecogLib_iOS.PageCodes?
    
    public let code: RecogLib_iOS.DocumentCodes?
    
    public let documents: [Document]?
    
    public let settings: DocumentVerifierSettings?
    
    public let scanningArea: CGRect?

    public init(
        showVisualisation: Bool,
        showHelperVisualisation: Bool,
        showDebugVisualisation: Bool,
        showTextInstructions: Bool = true,
        dataType: DataType,
        role: RecogLib_iOS.DocumentRole?,
        country: RecogLib_iOS.Country?,
        page: RecogLib_iOS.PageCodes?,
        code: RecogLib_iOS.DocumentCodes?,
        documents: [Document]?,
        settings: DocumentVerifierSettings?,
        scanningArea: CGRect? = nil
    ) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.showTextInstructions = showTextInstructions
        self.dataType = dataType
        self.role = role
        self.country = country
        self.page = page
        self.code = code
        self.documents = documents
        self.settings = settings
        self.scanningArea = scanningArea
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
    
    func controller(_ controller: DocumentController, didScan result: DocumentResult, nfcCode: String)
    
    func controller(_ controller: DocumentController, didScan result: DocumentResult)
    
    func controller(_ controller: DocumentController, didRecord videoURL: URL)
    
    func controller(_ controller: DocumentController, didUpdate result: DocumentResult)
}

#if targetEnvironment(simulator)
    public protocol SimulatorHelperDelegate: AnyObject {
        func provideDebugImage(for id: String, completion: @escaping (UIImage) -> Void)
    }
#endif

public protocol DocumentControllerAbstraction {
    var delegate: DocumentControllerDelegate? { get set }
    func configure(configuration: DocumentControllerConfiguration) throws
}

public final class DocumentController: BaseController<DocumentResult>, DocumentControllerAbstraction {
    
    public weak var delegate: DocumentControllerDelegate?
    #if targetEnvironment(simulator)
        public weak var debugDelegate: SimulatorHelperDelegate?
    #endif

    override var overlayImageName: String {
        switch config.role {
        case .Pas: "targettingRectPas"
        case .Birth: "targettingRectBirth"
        default: "targettingRect"
        }
    }
    
    
    override var shouldBeTorchEnabled: Bool { baseConfig.dataType == .video }

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
            ApplicationLogger.shared.Debug("didTapDebugButton: \(id)")
            switch id {
            case "id-front":
                guard let image = UIImage(named: "vzor-id-front") else { return }
                guard let buffer = image.toCMSampleBuffer() else { return }
                isRunning = true
                previewFrame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                cameraDelegate(camera: camera, onOutput: buffer)

            case "id-back":
                debugDelegate?.provideDebugImage(for: "id-back") { [weak self] image in
                    guard let self, let buffer = image.toCMSampleBuffer() else { return }
                    self.isRunning = true
                    self.previewFrame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                    self.cameraDelegate(camera: camera, onOutput: buffer)
                }
            default:
                break
            }
        }
    #endif

    public init(
        camera: Camera,
        view: CameraView,
        modelsUrl: URL? = nil,
        mrzModelsUrl: URL? = nil,
        language: SupportedLanguages = SupportedLanguages.current
    ) {
        verifier = .init(
            role: RecogLib_iOS.DocumentRole.Idc,
            country: RecogLib_iOS.Country.Cz,
            page: RecogLib_iOS.PageCodes.F,
            code: nil,
            language: language
        )
        super.init(camera: camera, view: view)

        #if targetEnvironment(simulator)
            debugButton.addTarget(self, action: #selector(didTapDebugButton(sender:)), for: .touchUpInside)
            debugButtonBack.addTarget(self, action: #selector(didTapDebugButton(sender:)), for: .touchUpInside)
        #endif

        if let modelsUrl {
            loadModels(url: modelsUrl, mrzURL: mrzModelsUrl)
        } else {
            loadModelsFromBundle()
        }
    }

    deinit {
        if baseConfig.dataType == .video {
            verifier.endHologramVerification()
            videoWriter?.stop()
        }
        camera.stop()
        verifier.reset()
        resetDocumentVerifier()
    }

    public func configure(configuration: DocumentControllerConfiguration = .default) throws {
        verifier.endHologramVerification()
        verifier.reset()
        let oldConfig = config
        config = configuration

        view?.topLabel.text = config.page == .B 
            ? LocalizedString("msg-scan-back", comment: "")
            : LocalizedString("msg-scan-front", comment: "")

        // Enrico: For documents, we should leave the resolution and fps fields blanks until we have test results.
        // verifier.getRequiredResolution(), verifier.getRequiredFPS()

        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showHelperVisualisation,
            showTextInstructions: configuration.showTextInstructions,
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

        verifier.showDebugInfo = config.showDebugVisualisation

        try configure(configuration: baseConfig)
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self else { return }
            if baseConfig.dataType == .video {
                verifier.reset()
                verifier.beginHologramVerification()
            } else {
                verifier.reset()
            }
        }

        #if targetEnvironment(simulator)
            if let overlay = view?.overlay {
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
    
    override func restart() {
        super.restart()
    
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            if baseConfig.dataType == .video {
                verifier.endHologramVerification()
                verifier.reset()
                verifier.beginHologramVerification()
            } else {
                verifier.reset()
            }
            
        }
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

        let result = verifier.getDocumentResult()
        return result
    }

    public func skipNfcResult() -> DocumentResult? {
        ApplicationLogger.shared.Debug("calling skipNfcResult()")
        verifier.processNfc(jsonData: "", status: .UserSkipped)

        let result = verifier.getDocumentResult()
        return result
    }

    public func getSignedImage() -> ImageSignature? {
        verifier.getSignedImage()
    }

    public func getNfcSettings() -> DocumentVerifierNfcValidatorSettings {
        verifier.getNfcValidatorSettings()
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
            var mutableResult = result
            //let preview = verifier.getImagePreview()   // TODO: it's crashing now
            var previewImageData: Data = UIImage().pngData() ?? Data()
            if let latestSuccessfullBuffer {
                let previewImage = UIImage(pixelBuffer: latestSuccessfullBuffer)
                if let data = previewImage?.pngData() {
                    previewImageData = data
                }
            }
            mutableResult.signature = ImageSignature(image: previewImageData, signature: "")
            
            delegate?.controller(self, didScan: mutableResult, nfcCode: mrzCode)
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
    
    override func onLayoutChange() {
        super.onLayoutChange()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            if baseConfig.dataType == .video {
                verifier.endHologramVerification()
                verifier.reset()
                verifier.beginHologramVerification()
            } else {
                verifier.reset()
            }
        }
    }

    private func loadModels(url: URL, mrzURL: URL?) {   
        verifier.loadModels(.init(url: url)!, mrzModelsPath: mrzURL)
    }
    
    private func loadModelsFromBundle() {
        let appDir = Bundle.main.bundleURL
        do {
            let list = if #available(iOS 16.0, *) {
                try FileManager.default.contentsOfDirectory(atPath: appDir.path(percentEncoded: false))
            } else {
                try FileManager.default.contentsOfDirectory(atPath: appDir.path)
            }
            let bundles = list
                .filter { $0.hasPrefix("ZenIDSDK_Documents") && $0.hasSuffix(".bundle") }
            
            bundles.forEach { file in
                if let url = Bundle(url: appDir.urlFor(file: file, in: appDir))?.resourceURL {
                    verifier.loadModels(.init(url: url)!)
                }
            }
            if let mrzUrl = Bundle(url: appDir.urlFor(file: "ZenIDSDK_MRZ.bundle", in: appDir))?.resourceURL {
                verifier.loadMrzModels(mrzUrl)
            }
        } catch {
                
        }
    }

    private func resetDocumentVerifier() {
        verifier.documentsInput = nil
        verifier.documentRole = nil
        verifier.page = nil
        verifier.country = nil
        verifier.code = nil
    }
}
