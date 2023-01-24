import Foundation

public final class UnifiedSelfieResultAdapter: UnifiedResult {
    
    public let state: UnifiedState
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let code: RecogLib_iOS.DocumentCodes?
    public let page: RecogLib_iOS.PageCodes?
    public let signature: ImageSignature?
    
    public init(result: SelfieResult) {
        state = result.selfieState.toDomain()
        role = nil
        country = nil
        code = nil
        page = nil
        signature = result.signature
    }
    
}

public extension SelfieVerifierState {
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
        case .BadFaceAngle:
            return .badFaceAngle
        }
    }
}
