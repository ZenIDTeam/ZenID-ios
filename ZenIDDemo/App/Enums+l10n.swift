import Common
import Foundation

extension DocumentType {
    var title: String {
        switch self {
        case .idCard:
            return "btn-id".localized.uppercased()
        case .drivingLicence:
            return "btn-driving-licence".localized.uppercased()
        case .passport:
            return "btn-passport".localized.uppercased()
        case .unspecifiedDocument:
            return "btn-unspecified-document".localized.uppercased()
        case .otherDocument:
            return "btn-other-document".localized.uppercased()
        case .face:
            return "btn-face".localized.uppercased()
        case .filter:
            return NSLocalizedString("btn-filter", comment: "").uppercased()
        case .documentVideo:
            return NSLocalizedString("btn-hologram", comment: "").uppercased()
        }
    }
}
