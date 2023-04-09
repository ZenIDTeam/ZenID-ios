import Foundation
import NFCDocumentReader
import UIKit

final class ReadNfcViewModel {
    struct InputData {
        let number: String
        let dateOfBirth: Date
        let dateOfExpiry: Date
    }

    enum DataObject {
        case text(String, String)
        case image(UIImage)
        case data(String)
    }

    let nfcReader = DocumentReader(logLevel: .debug)
    let mrzKey: String

    var sections: [String] = []
    var items: [[DataObject]] = []
    var document: NFCDocumentModel?

    init(_ data: InputData) {
        let df = DateFormatter()
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.dateFormat = "YYMMdd"

        let pptNr = data.number
        let dob = df.string(from: data.dateOfBirth)
        let doe = df.string(from: data.dateOfExpiry)

        let mrzKey = NfcUtils.getMRZKey(documentNumber: pptNr, dateOfBirth: dob, dateOfExpiry: doe)
        self.mrzKey = mrzKey
    }

    init(mrzKey: String) {
        self.mrzKey = mrzKey
    }

    func scan() async throws {
        Log.debug("mrzKey = \(mrzKey)")

        // Set the masterListURL on the Passport Reader to allow auto document verification
        let masterListURL = Bundle.main.url(forResource: "masterList", withExtension: ".pem")!
        nfcReader.setMasterListURL(masterListURL)

        // Set whether to use the new Passive Authentication verification method (default true) or the old OpenSSL CMS verifiction
        nfcReader.passiveAuthenticationUsesOpenSSL = true //! settings.useNewVerificationMethod

//        let customMessageHandler: (NFCViewDisplayMessage) -> String? = { displayMessage in
//            switch displayMessage {
//            case .requestPresentDocument:
//                return "Hold your iPhone near an NFC enabled passport."
//            default:
//                // Return nil for all other messages so we use the provided default
//                return nil
//            }
//        }

        let document = try await nfcReader.readDocument(mrzKey: mrzKey, customDisplayMessage: nil)
        self.document = document
        setupContent(document)
    }

    func setupContent(_ data: NFCDocumentModel) {
        sections = []
        items = []

        // image
        sections.append("Face image")
        if let passportImage = data.documentImage {
            items.append([
                .image(passportImage),
            ])
        }

        // personal information
        sections.append("Personal information")
        items.append([
            .text("Full name", "\(data.firstName) \(data.lastName)"),
            .text("Given names", "\(data.firstName)"),
            .text("Name", "\(data.lastName)"),
            .text("Gender", "\(data.gender)"),
            .text("Nationality", "\(data.nationality)"),
            .text("Date of birth", "\(data.dateOfBirth)"),
            .text("Personal number", "\(data.personalNumber ?? "")"),
        ])

        // validity
        sections.append("Chip information")
        items.append(getChipInfoSection(data))

        // Verification
        sections.append("Verification")
        items.append(getVerificationDetailsSection(data))

        // document information
        sections.append("Document information")
        items.append([
            .text("Document type", data.documentType),
            .text("Document subType", data.documentSubType),
            .text("Document number", data.documentNumber),
            .text("Document country", data.issuingAuthority),
            .text("Date of expiry", data.documentExpiryDate),
        ])

        // MRZ
        sections.append("MRZ from chip")
        items.append([
            .data(data.documentMRZ),
        ])
    }

    // Build Chip info section
    func getChipInfoSection(_ data: NFCDocumentModel) -> [DataObject] {
        [
            .text("LDS Version", data.LDSVersion),
            .text("Data groups present", data.dataGroupsPresent.joined(separator: ", ")),
            .text("Data groups read", data.dataGroupsAvailable.map { $0.getName() }.joined(separator: ", ")),
        ]
    }

    func getVerificationDetailsSection(_ data: NFCDocumentModel) -> [DataObject] {
        // Build Verification Info section
        var activeAuth: String = "Not supported"
        if data.activeAuthenticationSupported {
            activeAuth = data.activeAuthenticationPassed ? "SUCCESS\nSignature verified" : "FAILED\nCould not verify signature"
        }
        var chipAuth: String = "Not supported"
        if data.isChipAuthenticationSupported {
            switch data.chipAuthenticationStatus {
            case .notDone:
                chipAuth = "Supported - Not done"
            case .success:
                chipAuth = "SUCCESS\nSignature verified"
            case .failed:
                chipAuth = "FAILED\nCould not verify signature"
            }
        }

        var authType: String = "Authentication not done"
        if data.PACEStatus == .success {
            authType = "PACE"
        } else if data.BACStatus == .success {
            authType = "BAC"
        }

        // Do PACE Info
        var paceStatus = "Not Supported"
        if data.isPACESupported {
            switch data.PACEStatus {
            case .notDone:
                paceStatus = "Supported - Not done"
            case .success:
                paceStatus = "SUCCESS"
            case .failed:
                paceStatus = "FAILED"
            }
        }

        return [
            .text("Access Control", authType),
            .text("PACE", paceStatus),
            .text("Chip Authentication", chipAuth),
            .text("Active Authentication", activeAuth),
            .text("Document Signing Certificate", data.documentSigningCertificateVerified ? "SUCCESS\nSOD Signature verified" : "FAILED\nCouldn't verify SOD signature"),
            .text("Country signing Certificate", data.documentCorrectlySigned ? "SUCCESS\nmatched to country signing certificate" : "FAILED\nCouldn't build trust chain"),
            .text("Data group hashes", data.documentDataNotTampered ? "SUCCESS\nAll hashes match" : "FAILED\nCouldn't match hashes"),
        ]
    }
}
