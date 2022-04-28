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
        showDebugVisualisation: false,
        dataType: .picture
    )
    
    public let showVisualisation: Bool
    public let showHelperVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    
    public init(showVisualisation: Bool, showHelperVisualisation: Bool, showDebugVisualisation: Bool, dataType: DataType) {
        self.showVisualisation = showVisualisation
        self.showHelperVisualisation = showHelperVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.dataType = dataType
    }
}

public protocol SelfieControllerDelegate: AnyObject {
    func controller(_ controller: SelfieController, didScan result: SelfieResult)
    func controller(_ controller: SelfieController, didRecord videoURL: URL)
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
    
    public init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(language: .English)
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    public func configure(configuration: SelfieControllerConfiguration = .default) throws {
        view.topLabel.text = LocalizedString("msg-scan-face", comment: "")
        
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation,
            showHelperVisualisation: configuration.showVisualisation,
            dataType: configuration.dataType,
            cameraType: .front
        )
        
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
    }
    
    override func verify(pixelBuffer: CVPixelBuffer) -> SelfieResult? {
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
    
    override func callDelegate(with result: SelfieResult) {
        delegate?.controller(self, didScan: result)
    }
    
    override func callDelegate(with videoUrl: URL) {
        delegate?.controller(self, didRecord: videoUrl)
    }
    
    override func callUpdateDelegate(with result: SelfieResult) {
        delegate?.controller(self, didUpdate: result)
    }
    
    private func loadModels(url: URL) {
        verifier.loadModels(.init(url: url)!)
    }
}
