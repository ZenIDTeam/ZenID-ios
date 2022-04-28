import Foundation

public final class UnifiedFacelivenessResultAdapter: UnifiedResult {
    
    public let state: UnifiedState
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let code: RecogLib_iOS.DocumentCode?
    public let page: RecogLib_iOS.PageCode?
    public let signature: ImageSignature?
    
    public init(result: FaceLivenessResult) {
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
        case .holdStill:
            return .holdSteady
        }
    }
}
