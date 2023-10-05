import Foundation

public final class UnifiedFacelivenessResultAdapter: UnifiedResult {
    
    public let state: UnifiedState
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let code: RecogLib_iOS.DocumentCodes?
    public let page: RecogLib_iOS.PageCodes?
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

extension FaceLivenessVerifierState {
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
        case .Blurry:
            return .blurry
        case .Dark:
            return .dark
        case .HoldStill:
            return .holdSteady
        case .Reseting:
            return .reseting
        case .DontSmile:
            return .dontSmile
        }
    }
}
