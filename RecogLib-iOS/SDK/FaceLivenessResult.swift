import Foundation

public struct FaceLivenessResult {
    public var faceLivenessState: FaceLivenessState
    public let signature: ImageSignature?
    
    init?(faceLivenessState: Int32, signature: CImageSignature) {
        guard let faceLivenessState = FaceLivenessState(rawValue: Int(faceLivenessState)) else {
            return nil
        }
        self.faceLivenessState = faceLivenessState
        self.signature = DocumentSignatureMapper.map(signature)
    }
}
