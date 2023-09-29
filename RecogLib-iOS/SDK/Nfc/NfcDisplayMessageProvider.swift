public protocol NfcDisplayMessageProvider {
    func message(for: NFCDisplayMessage) -> String
}

public struct DefaultMesageProvider: NfcDisplayMessageProvider {
    /// Method to
    public func message(for displayMessage: NFCDisplayMessage) -> String {
        switch displayMessage {
        case .requestPresent:
            return "Hold your iPhone near an NFC enabled document."
        case let .authenticatingWith(progress):
            let progressString = handleProgress(percentualProgress: progress)
            return "Authenticating .....\n\n\(progressString)"
        case let .readingDataGroupProgress(dataGroup, progress):
            let progressString = handleProgress(percentualProgress: progress)
            var groupName = "personal data"
            if dataGroup == .DG2 {
                groupName = "photo"
            }
            return "Reading \(groupName).....\n\n\(progressString)"
        case let .error(tagError):
            switch tagError {
            case .TagNotValid:
                return "Tag not valid."
            case .MoreThanOneTagFound:
                return "More than 1 tags was found. Please present only 1 tag."
            case .ConnectionError:
                return "Connection error. Please try again."
            case .InvalidMRZKey:
                return "MRZ Key not valid for this document."
            case let .ResponseError(description, sw1, sw2):
                return "Sorry, there was a problem reading the document. \(description) - (0x\(sw1), 0x\(sw2)"
            default:
                return "Sorry, there was a problem reading the document. Please try again"
            }
        case .successfullRead:
            return "Document read successfully"
        }
    }

    public func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress / 20)
        let full = String(repeating: "🟦 ", count: p)
        let empty = String(repeating: "⬜️ ", count: 5 - p)
        return "\(full)\(empty)"
    }
}
