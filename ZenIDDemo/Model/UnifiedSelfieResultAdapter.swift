
import Foundation
import RecogLib_iOS


final class UnifiedSelfieResultAdapter: UnifiedResult {
    
    let state: UnifiedState
    let role: RecogLib_iOS.DocumentRole?
    let country: RecogLib_iOS.Country?
    let code: RecogLib_iOS.DocumentCode?
    let page: RecogLib_iOS.PageCode?
    let signature: ImageSignature?
    
    init(result: SelfieResult) {
        state = result.selfieState.toDomain()
        role = nil
        country = nil
        code = nil
        page = nil
        signature = result.signature
    }
    
}

extension SelfieState {
    func toDomain() -> UnifiedState {
        switch self {
        case .ConfirmingFace:
            return .confirming
        case .Blurry:
            return .blurry
        case .Dark:
            return .dark
        case .NoFaceFound:
            return .notFound
        case .Ok:
            return .ok
        case .badFaceAngle:
            return .badFaceAngle
        }
    }
}
