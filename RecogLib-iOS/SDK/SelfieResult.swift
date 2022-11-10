import Foundation

public struct SelfieResult {
    public var selfieState: SelfieState
    public let signature: ImageSignature?

    init?(selfieState: Int32, signature: CImageSignature) {
        guard let selfieState = SelfieState(rawValue: Int(selfieState)) else {
            return nil
        }
        self.selfieState = selfieState
        self.signature = DocumentSignatureMapper.map(signature)
    }
}
