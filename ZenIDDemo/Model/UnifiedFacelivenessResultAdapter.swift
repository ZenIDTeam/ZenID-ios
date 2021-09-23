
import Foundation
import RecogLib_iOS


final class UnifiedFacelivenessResultAdapter: UnifiedResult {
    
    let state: UnifiedState
    let role: RecogLib_iOS.DocumentRole?
    let country: RecogLib_iOS.Country?
    let code: RecogLib_iOS.DocumentCode?
    let page: RecogLib_iOS.PageCode?
    let signature: ImageSignature?
    
    init(result: FaceLivenessResult) {
        state = result.faceLivenessState.toDomain()
        role = nil
        country = nil
        code = nil
        page = nil
        signature = result.signature
    }
    
}

extension FaceLivenessState {
    func toDomain() -> UnifiedState {
        switch self {
        case .LookAtMe:
            return .lookAtMe
        case .TurnHead:
            return .turnHead
        case .Smile:
            return .smile
        case .Ok:
            return .ok
        case .blurry:
            return .blurry
        case .dark:
            return .dark
        }
    }
}
