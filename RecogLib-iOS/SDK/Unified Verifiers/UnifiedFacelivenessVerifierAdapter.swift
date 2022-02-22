
import Foundation
import RecogLib_iOS


public final class UnifiedFacelivenessVerifierAdapter: UnifiedVerifier {
    
    private let verifier: FaceLivenessVerifier
    
    public init(verifier: FaceLivenessVerifier) {
        self.verifier = verifier
    }
    
    public func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image) else {
            return nil
        }
        return UnifiedFacelivenessResultAdapter(result: result)
    }
    
}

extension UnifiedFacelivenessVerifierAdapter: VerifierRenderable {
    public func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height))
    }
}
