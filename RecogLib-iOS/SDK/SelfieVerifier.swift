import Foundation
import CoreMedia

public class SelfieVerifier {
    
    private var cppObject: UnsafeMutableRawPointer?
    
    public var language: SupportedLanguages
    
    public var showDebugInfo: Bool = false {
        didSet {
            setSelfieDebugInfo(cppObject, showDebugInfo)
        }
    }
        
    public init(language: SupportedLanguages) {
        self.language = language
    }
    
    public func loadModels(_ loader: FaceVerifierModels) {
        var settings = CSelfieVerifierSettings(visualizerVersion: 1)
        cppObject = RecogLib_iOS.getSelfieVerifier(&settings)
        RecogLib_iOS.loadSelfie(cppObject, loader.url.path.toUnsafeMutablePointer()!)
    }
    
    deinit {
        if cppObject != nil {
            deleteSelfieVerifier(cppObject)
        }
    }
    
    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> SelfieResult? {
        var selfie = createSelfieInfo(orientation: orientation)
        RecogLib_iOS.verifySelfie(cppObject, buffer, &selfie)
        return SelfieResult(selfieState: selfie.state, signature: selfie.signature)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> SelfieResult? {
        var selfie = createSelfieInfo(orientation: orientation)
        RecogLib_iOS.verifySelfieImage(cppObject, imageBuffer, &selfie)
        return SelfieResult(selfieState: selfie.state, signature: selfie.signature)
    }
    
    public func reset() {
        RecogLib_iOS.selfieVerifierReset(cppObject)
    }
    
    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var selfie = createSelfieInfo(orientation: orientation)
        let cString = RecogLib_iOS.getSelfieRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &selfie)
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
    
    private func createSelfieInfo(orientation: UIInterfaceOrientation) -> CSelfieInfo {
        return CSelfieInfo(
            state: -1,
            orientation: Int32(orientation.rawValue),
            language: Int32(language.rawValue),
            signature: .init()
        )
    }
}
