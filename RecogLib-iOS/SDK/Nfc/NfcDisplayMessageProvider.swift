public protocol NfcDisplayMessageProvider {
    func message(for: NFCDisplayMessage) -> String
}

public struct DefaultMesageProvider: NfcDisplayMessageProvider {
    /// Method to
    public func message(for displayMessage: NFCDisplayMessage) -> String {
        switch displayMessage {
        case .requestPresent:
            return LocalizedString("nfc-RequestPresent", comment: "")
        case let .authenticatingWith(progress):
            let progressString = handleProgress(percentualProgress: progress)
            return String(format: LocalizedString("nfc-Authenticating", comment: ""), progressString)
        case let .readingDataGroupProgress(dataGroup, progress):
            let progressString = handleProgress(percentualProgress: progress)
            var groupName = LocalizedString("nfc-Data-Personal", comment: "")
            if dataGroup == .DG2 {
                groupName = LocalizedString("nfc-Data-Photo", comment: "")
            }
            return String(format: LocalizedString("nfc-Reading", comment: ""), groupName, progressString)
        case let .error(tagError):
            switch tagError {
            case .TagNotValid:
                return LocalizedString("nfc-Error-InvalidTag", comment: "")
            case .MoreThanOneTagFound:
                return LocalizedString("nfc-Error-MoreTags", comment: "")
            case .ConnectionError:
                return LocalizedString("nfc-Error-Connection", comment: "")
            case .InvalidMRZKey:
                return LocalizedString("nfc-Error-InvalidMRZ", comment: "")
            case let .ResponseError(description, sw1, sw2):
                return String(format: LocalizedString("nfc-Error-CantReadFormat", comment: ""), description, sw1, sw2)
            default:
                return LocalizedString("nfc-Error-CantRead", comment: "")
            }
        case .successfullRead:
            return LocalizedString("nfc-Success", comment: "")
        }
    }

    public func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress / 20)
        let full = String(repeating: "🟦 ", count: p)
        let empty = String(repeating: "⬜️ ", count: 5 - p)
        return "\(full)\(empty)"
    }
}
