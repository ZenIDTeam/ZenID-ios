
import Foundation
import RecogLib_iOS


final class UnifiedDocumentVerifierAdapter: UnifiedVerifier {
    
    private let verifier: DocumentVerifier
    
    init(verifier: DocumentVerifier) {
        self.verifier = verifier
    }
    
    func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image) else {
            return nil
        }
        return UnifiedDocumentResultAdapter(result: result)
    }
    
}

extension UnifiedDocumentVerifierAdapter: VerifierRenderable {
    func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height))
    }
}
