//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//

public protocol NfcDocumentReaderProtocol {
    func read() async throws -> NfcData
    func read(skipSecureElements: Bool, skipPACE: Bool) async throws -> NfcData
}
