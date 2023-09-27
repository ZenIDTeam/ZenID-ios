public enum NFCDisplayMessage {
    case requestPresent
    case authenticatingWith(Int)
    case readingDataGroupProgress(DataGroupId, Int)
    case error(NfcDocumentReaderError)
    case successfullRead
}
