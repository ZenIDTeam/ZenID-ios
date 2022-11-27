//
//  Model.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

public enum SampleType: String, Decodable {
    case documentPicture = "DocumentPicture"
    case selfie = "Selfie"
    case selfieVideo = "SelfieVideo"
    case documentVideo = "DocumentVideo"
    case archived = "Archived"
    case unknown = "Unknown"
}

public enum SampleItemState: String, Decodable {
    case notDone = "NotDone"
    case done = "Done"
    case error = "Error"
    case op = "Operator"
    case rejected = "Rejected"
}

public enum MrzType: String, Decodable {
    case idV2000 = "ID_v2000"
    case idV2012 = "ID_v2012"
    case pasV2006 = "PAS_v2006"
    case unknown = "Unknown"
    case autIdc2002 = "AUT_IDC2002"
    case autPas2006 = "AUT_PAS2006"
    case svkIdc2008 = "SVK_IDC2008"
    case svkDl2013 = "SVK_DL2013"
    case svkPas2008 = "SVK_PAS2008"
    case polIdc2015 = "POL_IDC2015"
    case hrvIdc2003 = "HRV_IDC2003"
    case czeRes2011 = "CZE_RES_2011_14"
}

public enum MrzSubtype: String, Decodable {
    case op = "OP"
    case r = "R"
    case d = "D"
    case s = "S"
    case deflt = "Default"
    case unknown = "Unknown"
}

public extension RecogLib_iOS.DocumentCode {
    func isTypeOfDocument(type: DocumentType) -> Bool {
        let typeUpper = type.rawValue.uppercased()
        return description.uppercased().contains(typeUpper)
    }

    func isTypeOfDocument(type: String) -> Bool {
        let typeUpper = type.uppercased()
        return description.uppercased().contains(typeUpper)
    }

    var documentType: DocumentType {
        for tp in [DocumentType.drivingLicence, .idCard, .passport] {
            if isTypeOfDocument(type: tp) {
                return tp
            }
        }
        return .idCard // This shoudn't happen
    }
}

public enum PageCode: String, Decodable {
    case front = "F"
    case back = "B"
}

public enum ValidatorCodes: Int {
    case selfie = 6
    case ministry = 19
}

public struct Hash: Decodable {
    public var AsText: String?
    public var IsNull: Bool?
}

public struct MineAllResult: Decodable {
    public var FirstName: MinedText?
    public var LastName: MinedText?
    public var Address: MinedAddress?
    public var BirthAddress: MinedText?
    public var BirthLastName: MinedText?
    public var BirthNumber: MinedRc?
    public var BirthDate: MinedDate?
    public var ExpiryDate: MinedDate?
    public var IssueDate: MinedDate?
    public var IdcardNumber: MinedText?
    public var DrivinglicenseNumber: MinedText?
    public var PassportNumber: MinedText?
    public var Sex: MinedSex?
    public var Nationality: MinedText?
    public var Authority: MinedText?
    public var MaritalStatus: MinedMaritalStatus?
    public var Photo: MinedPhoto?
    public var Mrz: MinedMrz?
    public var DocumentCode: String?
    public var PageCode: PageCode?
    public var Height: MinedText?
    public var EyesColor: MinedText?

    public var documentCode: RecogLib_iOS.DocumentCode? {
        RecogLib_iOS.DocumentCode(stringValue: DocumentCode ?? "")
    }
}

public struct MinedText: Decodable {
    public var Text: String?
    public var Confidence: Int?
}

public struct MinedAddress: Decodable {
    public var A1: String?
    public var A2: String?
    public var A3: String?
    public var AdministrativeAreaLevel1: String?
    public var AdministrativeAreaLevel2: String?
    public var Locality: String?
    public var Sublocality: String?
    public var Street: String?
    public var HouseNumber: String?
    public var StreetNumber: String?
    public var PostalCode: String?
    public var Text: String?
    public var Confidence: Int?
}

public struct MinedRc: Decodable {
    public var BirthDate: String?
    public var Checksum: Int?
    public var Sex: String?
    public var Text: String?
    public var Confidence: Int?
}

public struct MinedDate: Decodable {
    public var Date: String?
    public var Format: String?
    public var Text: String?
    public var Confidence: Int?
}

public struct MinedSex: Decodable {
    public var Sex: String?
    public var Text: String?
    public var Confidence: Int?
}

public struct MinedMaritalStatus: Decodable {
    var MaritalStatus: String?
    var ImpliedSex: String?
    var Text: String?
    var Confidence: Int?
}

public struct MinedPhoto: Decodable {
    var ImageData: LazyMatImage?
    var EstimatedAge: Int?
    var EstimatedSex: String?
    var Text: String?
    var Confidence: Int?
}

public struct MinedMrz: Decodable {
    var Mrz: Mrz?
    var Text: String?
    var Confidence: Int?
}

public struct LazyMatImage: Decodable {
    var ImageHash: Hash?
}

public struct Mrz: Decodable {
    var MrzType: MrzType?
    var Subtype: MrzSubtype?
    var BirthDate: String?
    var BirthDateVerified: Bool?
    var DocumentNumber: String?
    var DocumentNumberVerified: Bool?
    var ExpiryDate: String?
    var ExpiryDateVerified: Bool?
    var GivenName: String?
    var ChecksumVerified: Bool?
    var ChecksumDigit: Int?
    var LastName: String?
    var Nationality: String?
    var Sex: String?
    var BirthNumber: String?
    var BirthNumberChecksum: Int?
    var BirthNumberVerified: Bool?
    var BirthdateChecksum: Int?
    var DocumentNumChecksum: Int?
    var ExpiryChecksum: Int?
    var BirthDateParsed: String?
    var ExpiryDateParsed: String?

    enum CodingKeys: String, CodingKey {
        case MrzType = "Type"
        case Subtype
        case BirthDate
        case BirthDateVerified
        case DocumentNumber
        case DocumentNumberVerified
        case ExpiryDate
        case ExpiryDateVerified
        case GivenName
        case ChecksumVerified
        case ChecksumDigit
        case LastName
        case Nationality
        case Sex
        case BirthNumber
        case BirthNumberChecksum
        case BirthNumberVerified
        case BirthdateChecksum
        case DocumentNumChecksum
        case ExpiryChecksum
        case BirthDateParsed
        case ExpiryDateParsed
    }
}
