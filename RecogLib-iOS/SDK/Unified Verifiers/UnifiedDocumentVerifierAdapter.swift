
import Foundation
import RecogLib_iOS


public final class UnifiedDocumentVerifierAdapter: UnifiedVerifier {
    
    private let verifier: DocumentVerifier
    private let orientation: UIInterfaceOrientation
    
    public init(verifier: DocumentVerifier, orientation: UIInterfaceOrientation) {
        self.verifier = verifier
        self.orientation = orientation
    }
    
    public func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image, orientation: orientation) else {
            return nil
        }
        return UnifiedDocumentResultAdapter(result: result)
    }
    
}

extension UnifiedDocumentVerifierAdapter: VerifierRenderable {
    public func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height), orientation: orientation)
    }
}
