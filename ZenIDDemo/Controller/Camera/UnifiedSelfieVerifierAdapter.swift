
import Foundation
import RecogLib_iOS


final class UnifiedSelfieVerifierAdapter: UnifiedVerifier {
    
    private let verifier: SelfieVerifier
    
    init(verifier: SelfieVerifier) {
        self.verifier = verifier
    }
    
    func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image) else {
            return nil
        }
        return UnifiedSelfieResultAdapter(result: result)
    }
    
}

extension UnifiedSelfieVerifierAdapter: VerifierRenderable {
    func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height))
    }
}
