public protocol NfcDocumentReaderProtocol {
    
    func read() async throws -> NfcData
    
    func read(skipSecureElements: Bool, skipPACE: Bool) async throws -> NfcData
}
