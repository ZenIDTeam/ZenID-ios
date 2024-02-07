public protocol NfcDisplayMessageProvider {
    func message(for: NFCDisplayMessage) -> String
}

public struct DefaultMesageProvider: NfcDisplayMessageProvider {
    /// Method to
    public func message(for displayMessage: NFCDisplayMessage) -> String {
        switch displayMessage {
        case .requestPresent:
            return NSLocalizedString("nfc-RequestPresent", bundle: Bundle.recogLib, comment: "")
        case let .authenticatingWith(progress):
            let progressString = handleProgress(percentualProgress: progress)
            return String(format: NSLocalizedString("nfc-Authenticating", bundle: Bundle.recogLib, comment: ""), progressString)
        case let .readingDataGroupProgress(dataGroup, progress):
            let progressString = handleProgress(percentualProgress: progress)
            var groupName = NSLocalizedString("nfc-Data-Personal", bundle: Bundle.recogLib, comment: "")
            if dataGroup == .DG2 {
                groupName = NSLocalizedString("nfc-Data-Photo", bundle: Bundle.recogLib, comment: "")
            }
            return String(format: NSLocalizedString("nfc-Reading", bundle: Bundle.recogLib, comment: ""), groupName, progressString)
        case let .error(tagError):
            switch tagError {
            case .TagNotValid:
                return NSLocalizedString("nfc-Error-InvalidTag", bundle: Bundle.recogLib, comment: "")
            case .MoreThanOneTagFound:
                return NSLocalizedString("nfc-Error-MoreTags", bundle: Bundle.recogLib, comment: "")
            case .ConnectionError:
                return NSLocalizedString("nfc-Error-Connection", bundle: Bundle.recogLib, comment: "")
            case .InvalidMRZKey:
                return NSLocalizedString("nfc-Error-InvalidMRZ", bundle: Bundle.recogLib, comment: "")
            case let .ResponseError(description, sw1, sw2):
                return String(format: NSLocalizedString("nfc-Error-CantReadFormat", bundle: Bundle.recogLib, comment: ""), description, sw1, sw2)
            default:
                return NSLocalizedString("nfc-Error-CantRead", bundle: Bundle.recogLib, comment: "")
            }
        case .successfullRead:
            return NSLocalizedString("nfc-Success", bundle: Bundle.recogLib, comment: "")
        }
    }

    public func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress / 20)
        let full = String(repeating: "🟦 ", count: p)
        let empty = String(repeating: "⬜️ ", count: 5 - p)
        return "\(full)\(empty)"
    }
}
