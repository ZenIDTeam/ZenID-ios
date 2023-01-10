import Foundation

public final class UnifiedHologramResultAdapter: UnifiedResult {
    
    public let state: UnifiedState
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let code: RecogLib_iOS.DocumentCodes?
    public let page: RecogLib_iOS.PageCodes?
    public let signature: ImageSignature?
    
    public init(result: HologramResult) {
        state = result.hologramState.toDomain()
        role = nil
        country = nil
        code = nil
        page = nil
        signature = nil
    }
    
}

public extension HologramState {
    func toDomain() -> UnifiedState {
        switch self {
        case .Center:
            return .center
        case .TiltUpAndDown:
            return .tiltUpAndDown
        case .TiltLeftAndRight:
            return .tiltLeftAndRight
        case .Ok:
            return .ok
        }
    }
}
