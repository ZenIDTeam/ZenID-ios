
import Foundation
import RecogLib_iOS


final class UnifiedFacelivenessVerifierAdapter: UnifiedVerifier {
    
    private let verifier: FaceLivenessVerifier
    
    init(verifier: FaceLivenessVerifier) {
        self.verifier = verifier
    }
    
    func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image) else {
            return nil
        }
        return UnifiedFacelivenessResultAdapter(result: result)
    }
    
}

extension UnifiedFacelivenessVerifierAdapter: VerifierRenderable {
    func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height))
    }
}
