import Foundation
import UIKit

extension FaceLivenessResult: ResultState {
    
    public var isOk: Bool {
        faceLivenessState == .Ok
    }
    
    public var description: String {
        faceLivenessState.description
    }
}

public struct FacelivenessControllerConfiguration {
    
    public static let `default` = FacelivenessControllerConfiguration(
        showVisualisation: true,
        showHelperVisualisation: true,
        showDebugVisualisation: false,
        dataType: .picture,
        settings: FaceLivenessVerifierSettings())
    
    public let showVisualisation: Bool
    
    public let showHelperVisualisation: Bool
    
    public let showDebugVisualisation: Bool
    
    public let showTextInstructions: Bool
    
    public let dataType: DataType
    
    public let settings: FaceLivenessVerifierSettings
    
    public init(
        showVisualisation: Bool,
        showHelperVisualisation: Bool,
        showDebugVisualisation: Bool,
        showTextInstructions: Bool = true,
        dataType: DataType,
        settings: FaceLivenessVerifierSettings
    ) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.showTextInstructions = showTextInstructions
        self.dataType = dataType
        self.settings = settings

    }
}

public protocol FacelivenessControllerDelegate: AnyObject {
    
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult)
    
    func controller(_ controller: FacelivenessController, didRecord videoURL: URL, result: FaceLivenessResult)
    
    func controller(_ controller: FacelivenessController, didUpdate result: FaceLivenessResult)
}

public protocol FacelivenessControllerAbstraction {
    
    var delegate: FacelivenessControllerDelegate? { get set }
    
    func configure(configuration: FacelivenessControllerConfiguration) throws
}

public final class FacelivenessController: BaseController<FaceLivenessResult>, FacelivenessControllerAbstraction {
    
    public weak var delegate: FacelivenessControllerDelegate?
    
    private let verifier: FaceLivenessVerifier
    
    private var config = FacelivenessControllerConfiguration.default
    
    override var canShowStaticOverlay: Bool { false }
    
    override var canShowInstructionView: Bool { false }
    
    public init(
        camera: Camera,
        view: CameraView,
        modelsUrl: URL? = nil,
        language: SupportedLanguages = SupportedLanguages.current
    ) {
        verifier = .init(language: language)
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    public func configure(configuration: FacelivenessControllerConfiguration = .default) throws {
        view?.topLabel.text = LocalizedString("msg-scan-face", comment: "")
        
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showHelperVisualisation,
            showTextInstructions: configuration.showTextInstructions,
            dataType: configuration.dataType,
            cameraType: .front,
            requestedResolution: verifier.getRequiredResolution(),
            requestedFPS: verifier.getRequiredFPS(),
            processType: .face
        )
        
        verifier.update(settings: configuration.settings)
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
        
        verifier.reset()
    }
    
    override func restart() {
        super.restart()
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            verifier.reset()
        }
    }
    
    public func getAuxiliaryImages() -> FaceLivenessAuxiliaryInfo? {
        verifier.getAuxiliaryInfo()
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> FaceLivenessResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer, flipImage: false)
    }
    
    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }
    
    override func callDelegate(with result: FaceLivenessResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        guard let result = verifier.getLivenessResult() else {
            ApplicationLogger.shared.Warn("Failed to get face liveness result.")
            return
        }
        delegate?.controller(self, didRecord: videoUrl, result: result)
    }
    
    override func callUpdateDelegate(with result: FaceLivenessResult) {
        // When reseting liveness verifier reset video recording too.
        if result.faceLivenessState == .Reseting, previousResult?.faceLivenessState != .Reseting {
            restartVideoWriter()
        }
        
        delegate?.controller(self, didUpdate: result)
    }
    
    private func loadModels(url: URL?) {
        let appDir = Bundle.main.bundleURL
        if let url = url ?? Bundle(url: appDir.urlFor(file: "ZenIDSDK_Faceliveness.bundle", in: appDir))?.resourceURL {
            guard let models = FaceVerifierModels(url: url) else {
                return
            }
            verifier.loadModels(models)
        }
    }
}
