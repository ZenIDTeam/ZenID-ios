
import Foundation
import RecogLib_iOS


final class UnifiedHologramResultAdapter: UnifiedResult {
    
    let state: UnifiedState
    let role: RecogLib_iOS.DocumentRole?
    let country: RecogLib_iOS.Country?
    let code: RecogLib_iOS.DocumentCode?
    let page: RecogLib_iOS.PageCode?
    let signature: ImageSignature?
    
    init(result: HologramResult) {
        state = result.hologramState.toDomain()
        role = nil
        country = nil
        code = nil
        page = nil
        signature = nil
    }
    
}

extension HologramState {
    func toDomain() -> UnifiedState {
        switch self {
        case .center:
            return .center
        case .tiltUpAndDown:
            return .tiltUpAndDown
        case .tiltLeftAndRight:
            return .tiltLeftAndRight
        case .ok:
            return .ok
        }
    }
}
