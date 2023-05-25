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
        settings: FaceLivenessVerifierSettings()
    )
    
    public let showVisualisation: Bool
    public let showHelperVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    public let settings: FaceLivenessVerifierSettings
    
    public init(showVisualisation: Bool, showHelperVisualisation: Bool, showDebugVisualisation: Bool, dataType: DataType, settings: FaceLivenessVerifierSettings) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.dataType = dataType
        self.settings = settings
    }
}

public protocol FacelivenessControllerDelegate: AnyObject {
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult)
    func controller(_ controller: FacelivenessController, didRecord videoURL: URL)
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
    
    public init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(language: .English)
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    public func configure(configuration: FacelivenessControllerConfiguration = .default) throws {
        view.topLabel.text = LocalizedString("msg-scan-face", comment: "")
        
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showHelperVisualisation,
            dataType: configuration.dataType,
            cameraType: .front,
            requestedResolution: verifier.getRequiredResolution(),
            requestedFPS: verifier.getRequiredFPS()
        )
        
        verifier.update(settings: configuration.settings)
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
    }
    
    public func getAuxiliaryImages() -> FaceLivenessAuxiliaryInfo? {
        verifier.getAuxiliaryInfo()
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> FaceLivenessResult? {
        verifier.verifyImage(imageBuffer: pixelBuffer)
    }
    
    override func getRenderCommands(size: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    }
    
    override func canShowStaticOverlay() -> Bool {
        false
    }
    
    override func canShowInstructionView() -> Bool {
        false
    }
    
    override func callDelegate(with result: FaceLivenessResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        delegate?.controller(self, didRecord: videoUrl)
    }
    
    override func callUpdateDelegate(with result: FaceLivenessResult) {
        delegate?.controller(self, didUpdate: result)
    }
    
    private func loadModels(url: URL) {
        guard let models = FaceVerifierModels(url: url) else {
            return
        }
        verifier.loadModels(models)
    }
}
