import Foundation
import UIKit
import RecogLib_iOS

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
        showDebugVisualisation: false,
        dataType: .picture
    )
    
    public let showVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    
    public init(showVisualisation: Bool, showDebugVisualisation: Bool, dataType: DataType) {
        self.showVisualisation = showVisualisation
        self.showDebugVisualisation = showDebugVisualisation
        self.dataType = dataType
    }
}

protocol SelfieControllerDelegate: AnyObject {
    func controller(_ controller: SelfieController, didScan result: SelfieResult)
    func controller(_ controller: SelfieController, didRecord videoURL: URL)
}

public final class SelfieController: BaseController<SelfieResult> {
    weak var delegate: SelfieControllerDelegate?
    
    private let verifier: SelfieVerifier
    
    private var config = SelfieControllerConfiguration.default
    
    public init(camera: Camera, view: CameraView, modelsUrl: URL) {
        verifier = .init(language: LanguageHelper.language)
        super.init(camera: camera, view: view)
        
        loadModels(url: modelsUrl)
    }
    
    public func configure(configuration: SelfieControllerConfiguration = .default) throws {
        verifier.reset()
        config = configuration
        
        let baseConfig = BaseControllerConfiguration(
            showVisualisation: configuration.showVisualisation && canShowVisualisation(),
            dataType: configuration.dataType,
            cameraType: .front
        )
        
        verifier.showDebugInfo = config.showDebugVisualisation
        
        try self.configure(configuration: baseConfig)
        
        //contentView.topLabel.text = photoType.message
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
    
    private func loadModels(url: URL) {
        verifier.loadModels(.init(url: url)!)
    }
}
