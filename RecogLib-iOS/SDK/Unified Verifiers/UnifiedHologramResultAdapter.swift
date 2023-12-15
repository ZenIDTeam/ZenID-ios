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
        return switch self {
        case .Center: .center
        case .TiltUpAndDown: .tiltUpAndDown
        case .TiltLeftAndRight: .tiltLeftAndRight
        case .Ok: .ok
        case .TimedOut: .timedOut
        case .TiltLeft: .tiltLeft
        case .TiltRight: .tiltRight
        case .TiltUp: .tiltUp
        case .TiltDown: .tiltDown
        }
    }
}
