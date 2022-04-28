import Foundation

public final class UnifiedSelfieVerifierAdapter: UnifiedVerifier {
    
    private let verifier: SelfieVerifier
    
    public init(verifier: SelfieVerifier) {
        self.verifier = verifier
    }
    
    public func verify(image: CVPixelBuffer) -> UnifiedResult? {
        guard let result = verifier.verifyImage(imageBuffer: image) else {
            return nil
        }
        return UnifiedSelfieResultAdapter(result: result)
    }
    
}

extension UnifiedSelfieVerifierAdapter: VerifierRenderable {
    public func getRenderCommands(canvasSize: CGSize) -> String? {
        verifier.getRenderCommands(canvasWidth: Int(canvasSize.width), canvasHeight: Int(canvasSize.height))
    }
}
