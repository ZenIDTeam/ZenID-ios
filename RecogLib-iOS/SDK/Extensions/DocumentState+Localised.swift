import Foundation

extension DocumentState {
    var localizedDescription: String {
        switch self {
        case .Ok:
            return NSLocalizedString("document.state.ok", comment: "")
        case .AlignCard:
            return NSLocalizedString("document.state.align.card", comment: "")
        case .Blurry:
            return NSLocalizedString("document.state.blurry", comment: "")
        case .HoldSteady:
            return NSLocalizedString("document.state.hold.steady", comment: "")
        case .NoMatchFound:
            return NSLocalizedString("document.state.no.match.found", comment: "")
        case .ReflectionPresent:
            return NSLocalizedString("document.state.reflection.present", comment: "")
        case .Hologram:
            return NSLocalizedString("document.state.hologram.error", comment: "")
        case .Dark:
            return NSLocalizedString("document.state.dark", comment: "")
        }
    }
}
