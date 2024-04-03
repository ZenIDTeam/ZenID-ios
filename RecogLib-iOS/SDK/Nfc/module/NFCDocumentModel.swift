//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//

import Foundation
import UIKit
@available(iOS 13.0.0, *)
public class NFCDocumentModel: NFCDocumentModelType {
    public private(set) lazy var documentType: String = { String(passportDataElements?["5F03"]?.first ?? "?") }()
    public private(set) lazy var documentSubType: String = { String(passportDataElements?["5F03"]?.last ?? "?") }()
    public private(set) lazy var documentNumber: String = { (passportDataElements?["5A"] ?? "?").replacingOccurrences(of: "<", with: "") }()
    public private(set) lazy var issuingAuthority: String = { passportDataElements?["5F28"] ?? "?" }()
    public private(set) lazy var documentExpiryDate: String = { passportDataElements?["59"] ?? "?" }()
    public private(set) lazy var dateOfBirth: String = { passportDataElements?["5F57"] ?? "?" }()
    public private(set) lazy var gender: String = { passportDataElements?["5F35"] ?? "?" }()
    public private(set) lazy var nationality: String = { passportDataElements?["5F2C"] ?? "?" }()

    public private(set) lazy var lastName: String = {
        names[0].replacingOccurrences(of: "<", with: " ")
    }()

    public private(set) lazy var firstName: String = {
        var name = ""
        for i in 1 ..< names.count {
            let fn = names[i].replacingOccurrences(of: "<", with: " ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            name += fn + " "
        }
        return name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }()

    public private(set) lazy var passportMRZ: String = { passportDataElements?["5F1F"] ?? "NOT FOUND" }()

    // Extract fields from DG11 if present
    private lazy var names: [String] = {
        guard let dg11 = dataGroupsRead[.DG11] as? DataGroup11,
              let fullName = dg11.fullName?.components(separatedBy: "<<") else { return (passportDataElements?["5B"] ?? "?").components(separatedBy: "<<") }
        return fullName
    }()

    public private(set) lazy var placeOfBirth: String? = {
        guard let dg11 = dataGroupsRead[.DG11] as? DataGroup11,
              let placeOfBirth = dg11.placeOfBirth else { return nil }
        return placeOfBirth
    }()

    /// residence address
    public private(set) lazy var residenceAddress: String? = {
        guard let dg11 = dataGroupsRead[.DG11] as? DataGroup11,
              let address = dg11.address else { return nil }
        return address
    }()

    /// phone number
    public private(set) lazy var phoneNumber: String? = {
        guard let dg11 = dataGroupsRead[.DG11] as? DataGroup11,
              let telephone = dg11.telephone else { return nil }
        return telephone
    }()

    /// personal number
    public private(set) lazy var personalNumber: String? = {
        if let dg11 = dataGroupsRead[.DG11] as? DataGroup11,
           let personalNumber = dg11.personalNumber { return personalNumber }

        return (passportDataElements?["53"] ?? "?").replacingOccurrences(of: "<", with: "")
    }()

    // Extract data from COM
    public private(set) lazy var LDSVersion: String = {
        guard let com = dataGroupsRead[.COM] as? COM else { return "Unknown" }
        return com.version
    }()

    public private(set) lazy var dataGroupsPresent: [String] = {
        guard let com = dataGroupsRead[.COM] as? COM else { return [] }
        return com.dataGroupsPresent
    }()

    // Parsed datagroup hashes
    public private(set) var dataGroupsAvailable = [DataGroupId]()
    public private(set) var dataGroupsRead: [DataGroupId: DataGroup] = [:]
//    public private(set) var dataGroupHashes = [DataGroupId: DataGroupHash]()

    // public internal(set) var cardAccess: CardAccess?
    public internal(set) var BACAuthStatus: AuthenticationStatus = .notDone
    public internal(set) var PACEAuthStatus: AuthenticationStatus = .notDone
    public internal(set) var chipAuthenticationStatus: AuthenticationStatus = .notDone

    public private(set) var passportCorrectlySigned: Bool = false
    public private(set) var documentSigningCertificateVerified: Bool = false
    public private(set) var passportDataNotTampered: Bool = false
    public private(set) var activeAuthenticationPassed: Bool = false
    public private(set) var activeAuthenticationChallenge: [UInt8] = []
    public private(set) var activeAuthenticationSignature: [UInt8] = []
    public private(set) var verificationErrors: [Error] = []

    public var isPACESupported: Bool {
        false
//        if cardAccess?.paceInfo != nil {
//            return true
//        } else {
//            // We may not have stored the cardAccess so check the DG14
//            if let dg14 = dataGroupsRead[.DG14] as? DataGroup14,
//               (dg14.securityInfos.filter { ($0 as? PACEInfo) != nil }).count > 0 {
//                return true
//            }
//            return false
//        }
    }

//    public var isChipAuthenticationSupported: Bool {
//        if let dg14 = dataGroupsRead[.DG14] as? DataGroup14,
//           (dg14.securityInfos.filter { ($0 as? ChipAuthenticationPublicKeyInfo) != nil }).count > 0 {
//            return true
//        } else {
//            return false
//        }
//    }

//    #if os(iOS)
    public var passportImage: UIImage? {
        guard let dg2 = dataGroupsRead[.DG2] as? DataGroup2 else { return nil }
        return dg2.getImage()
    }

    public var signatureImage: UIImage? {
        guard let dg7 = dataGroupsRead[.DG7] as? DataGroup7 else { return nil }
        return dg7.getImage()
    }

    private var passportDataElements: [String: String]? {
        guard let dg1 = dataGroupsRead[.DG1] as? DataGroup1 else { return nil }

        return dg1.elements
    }

    public init() {
    }

    public func addDataGroup(_ id: DataGroupId, dataGroup: DataGroup) {
        dataGroupsRead[id] = dataGroup
        if id != .COM && id != .SOD {
            dataGroupsAvailable.append(id)
        }
    }

    private func getDataGroup(_ id: DataGroupId) -> DataGroup? {
        return dataGroupsRead[id]
    }

    public func getDataGroupData(_ groupId: DataGroupId) -> [UInt8]? {
        getDataGroup(groupId)?.data
    }
    
    public func getEncodedDataGroup(_ groupId: DataGroupId) -> String? {
        getDataGroup(groupId)?.getContentEncoded()
    }


    /// Parses an text ASN1 structure, and extracts the Hash Algorythm and Hashes contained from the Octect strings
    /// - Parameter content: the text ASN1 stucure format
    /// - Returns: The Hash Algorythm used - either SHA1 or SHA256, and a dictionary of hashes for the datagroups (currently only DG1 and DG2 are handled)
    private func parseSODSignatureContent(_ content: String) throws -> (String, [DataGroupId: String]) {
        var currentDG = ""
        var sodHashAlgo = ""
        var sodHashes: [DataGroupId: String] = [:]

        let lines = content.components(separatedBy: "\n")

        let dgList: [DataGroupId] = [.COM, .DG1, .DG2, .DG3, .DG4, .DG5, .DG6, .DG7, .DG8, .DG9, .DG10, .DG11, .DG12, .DG13, .DG14, .DG15, .DG16, .SOD]

        for line in lines {
            if line.contains("d=2") && line.contains("OBJECT") {
                if line.contains("sha1") {
                    sodHashAlgo = "SHA1"
                } else if line.contains("sha224") {
                    sodHashAlgo = "SHA224"
                } else if line.contains("sha256") {
                    sodHashAlgo = "SHA256"
                } else if line.contains("sha384") {
                    sodHashAlgo = "SHA384"
                } else if line.contains("sha512") {
                    sodHashAlgo = "SHA512"
                }
            } else if line.contains("d=3") && line.contains("INTEGER") {
                if let range = line.range(of: "INTEGER") {
                    let substr = line[range.upperBound ..< line.endIndex]
                    if let r2 = substr.range(of: ":") {
                        currentDG = String(line[r2.upperBound...])
                    }
                }

            } else if line.contains("d=3") && line.contains("OCTET STRING") {
                if let range = line.range(of: "[HEX DUMP]:") {
                    let val = line[range.upperBound ..< line.endIndex]
                    if currentDG != "", let id = Int(currentDG, radix: 16) {
                        sodHashes[dgList[id]] = String(val)
                        currentDG = ""
                    }
                }
            }
        }

        if sodHashAlgo == "" {
            throw PassiveAuthenticationError.UnableToParseSODHashes("Unable to find hash algorythm used")
        }
        if sodHashes.count == 0 {
            throw PassiveAuthenticationError.UnableToParseSODHashes("Unable to extract hashes")
        }

        ApplicationLogger.shared.Debug("Parse SOD - Using Algo - \(sodHashAlgo)")
        ApplicationLogger.shared.Debug("      - Hashes     - \(sodHashes)")

        return (sodHashAlgo, sodHashes)
    }
}
