
import Foundation
import RecogLib_iOS


final class UnifiedDocumentResultAdapter: UnifiedResult {
    
    let state: UnifiedState
    let role: RecogLib_iOS.DocumentRole?
    let country: RecogLib_iOS.Country?
    let code: RecogLib_iOS.DocumentCode?
    let page: RecogLib_iOS.PageCode?
    let signature: ImageSignature?
    
    init(result: DocumentResult) {
        state = result.hologremState?.toDomain() ?? result.state.toDomain()
        role = result.role
        country = result.country
        code = result.code
        page = result.page
        signature = result.signature
    }
    
}

extension DocumentState {
    func toDomain() -> UnifiedState {
        switch self {
        case .AlignCard:
            return .alignCard
        case .Blurry:
            return .blurry
        case .Dark:
            return .dark
        case .HoldSteady:
            return .holdSteady
        case .NoMatchFound:
            return .notFound
        case .Ok:
            return .ok
        case .Hologram:
            return .hologram
        case .ReflectionPresent:
            return .reflectionPresent
        case .Barcode:
            return .barcode
        }
    }
}
