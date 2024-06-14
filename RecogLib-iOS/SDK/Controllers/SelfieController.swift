import Foundation
import UIKit

extension SelfieResult: ResultState {
    
    public var isOk: Bool {
        selfieState == .Ok
    }
    
    public var description: String {
        selfieState.description
    }
}

public struct SelfieControllerConfiguration {
    
    public static let `default` = SelfieControllerConfiguration(
        showVisualisation: true,
        showHelperVisualisation: true,
        showDebugVisualisation: false)
    
    public let showVisualisation: Bool
    
    public let showHelperVisualisation: Bool
    
    public let showDebugVisualisation: Bool
    
    public let showTextInstructions: Bool
    
    public let dataType: DataType = .picture
    
    public init(
        showVisualisation: Bool,
        showHelperVisualisation: Bool,
        showDebugVisualisation: Bool,
        showTextInstructions: Bool = true
    ) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.showTextInstructions = showTextInstructions
    }
}

public protocol SelfieControllerDelegate: AnyObject {
    
    func controller(_ controller: SelfieController, didScan result: SelfieResult)
    
    func controller(_ controller: SelfieController, didUpdate result: SelfieResult)
}

public protocol SelfieControllerAbstraction {
    
    var delegate: SelfieControllerDelegate? { get set }
    
    func configure(configuration: SelfieControllerConfiguration) throws
}

public final class SelfieController: BaseController<SelfieResult>, SelfieControllerAbstraction {
    
    public weak var delegate: SelfieControllerDelegate?
    
    private let verifier: SelfieVerifier
    
    private var config = SelfieControllerConfiguration.default
    
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
    
    public func configure(configuration: SelfieControllerConfiguration = .default) throws {
        view?.topLabel.text = LocalizedString("msg-scan-face", comment: "")
        
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showHelperVisualisation,
            showTextInstructions: configuration.showTextInstructions,
            dataType: configuration.dataType,
            cameraType: .front,
            requestedResolution: 0,
            requestedFPS: 0,
            processType: .selfie
        )
        
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
        
        verifier.reset()
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> SelfieResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer)
    }
    
    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }
    
    override func callDelegate(with result: SelfieResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        ApplicationLogger.shared.Error("Video is not supported for Selfie.")
    }
    
    override func callUpdateDelegate(with result: SelfieResult) {
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
