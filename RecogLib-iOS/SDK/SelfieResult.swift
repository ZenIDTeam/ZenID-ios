import Foundation

public struct SelfieResult {
    
    public var selfieState: SelfieVerifierState
    
    public let signature: ImageSignature?

    init?(selfieState: Int32, signature: CImageSignature) {
        guard let selfieState = SelfieVerifierState(rawValue: Int(selfieState)) else {
            return nil
        }
        self.selfieState = selfieState
        self.signature = DocumentSignatureMapper.map(signature)
    }
}
