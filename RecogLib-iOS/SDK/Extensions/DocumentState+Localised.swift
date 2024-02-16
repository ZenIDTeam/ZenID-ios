import Foundation

extension DocumentVerifierState {
    
    var localizedDescription: String {
        switch self {
        case .Ok:
            return LocalizedString("document.state.ok", comment: "")
        case .AlignCard:
            return LocalizedString("document.state.align.card", comment: "")
        case .Blurry:
            return LocalizedString("document.state.blurry", comment: "")
        case .HoldSteady:
            return LocalizedString("document.state.hold.steady", comment: "")
        case .NoMatchFound:
            return LocalizedString("document.state.no.match.found", comment: "")
        case .ReflectionPresent:
            return LocalizedString("document.state.reflection.present", comment: "")
        case .Hologram:
            return LocalizedString("document.state.hologram.error", comment: "")
        case .Dark:
            return LocalizedString("document.state.dark", comment: "")
        case .Barcode:
            return LocalizedString("document.state.barcode", comment: "")
        case .TextNotReadable:
            return LocalizedString("document.state.text_not_readable", comment: "")
        case .Nfc:
            return LocalizedString("document.state.nfc", comment: "")
        }
    }
}
