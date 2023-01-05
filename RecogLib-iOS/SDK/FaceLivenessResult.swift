import Foundation

public struct FaceLivenessResult {
    public var faceLivenessState: FaceLivenessVerifierState
    public let signature: ImageSignature?

    init?(faceLivenessState: Int32, signature: CImageSignature) {
        guard let faceLivenessState = FaceLivenessVerifierState(rawValue: Int(faceLivenessState)) else {
            return nil
        }
        self.faceLivenessState = faceLivenessState
        self.signature = DocumentSignatureMapper.map(signature)
    }
}
