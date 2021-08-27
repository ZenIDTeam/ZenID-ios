
import Foundation
import RecogLib_iOS


final class UnifiedHologramVerifierAdapter: UnifiedVerifier {
    
    private let verifier: DocumentVerifier
    
    init(verifier: DocumentVerifier) {
        self.verifier = verifier
    }
    
    func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyHologramImage(imageBuffer: image) else {
            return nil
        }
        return UnifiedHologramResultAdapter(result: result)
    }
    
}

extension UnifiedHologramVerifierAdapter: VerifierRenderable {
    func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height))
    }
}
