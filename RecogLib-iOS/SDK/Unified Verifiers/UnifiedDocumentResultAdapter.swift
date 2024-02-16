import Foundation

public final class UnifiedDocumentResultAdapter: UnifiedResult {
    
    public let state: UnifiedState
    
    public let role: RecogLib_iOS.DocumentRole?
    
    public let country: RecogLib_iOS.Country?
    
    public let code: RecogLib_iOS.DocumentCodes?
    
    public let page: RecogLib_iOS.PageCodes?
    
    public let signature: ImageSignature?
    
    public init(result: DocumentResult) {
        state = result.hologramState?.toDomain() ?? result.state.toDomain()
        role = result.role
        country = result.country
        code = result.code
        page = result.page
        signature = result.signature
    }
    
}

public extension DocumentVerifierState {
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
        case .TextNotReadable:
            return .textNotReadable
        case .Nfc:
            return .nfc
        }
    }
}
