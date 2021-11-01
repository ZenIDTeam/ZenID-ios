
import Foundation
import RecogLib_iOS


final class UnifiedDocumentVerifierAdapter: UnifiedVerifier {
    
    private let verifier: DocumentVerifier
    private let orientation: UIInterfaceOrientation
    
    init(verifier: DocumentVerifier, orientation: UIInterfaceOrientation) {
        self.verifier = verifier
        self.orientation = orientation
    }
    
    func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image, orientation: orientation) else {
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
