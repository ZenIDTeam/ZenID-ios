//
//  Model.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation

enum SampleType: String, Decodable {
    case documentPicture = "DocumentPicture"
    case selfie = "Selfie"
    case selfieVideo = "SelfieVideo"
    case documentVideo = "DocumentVideo"
    case archived = "Archived"
    case unknown = "Unknown"
}

enum SampleItemState: String, Decodable {
    case notDone = "NotDone"
    case done = "Done"
    case error = "Error"
    case op = "Operator"
    case rejected = "Rejected"
}

enum MrzType: String, Decodable {
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

enum MrzSubtype: String, Decodable {
    case op = "OP"
    case r = "R"
    case d = "D"
    case s = "S"
    case deflt = "Default"
    case unknown = "Unknown"
}

enum DocumentCode: String, Decodable {
    case idc1 = "IDC1"
    case idc2 = "IDC2"
    case drv = "DRV"
    case pas = "PAS"
    case skIdc2008plus = "SK_IDC_2008plus"
    case skIdc1993 = "SK_IDC_1993"
    case skPas2005 = "SK_PAS_2005"
    case skPas2008 = "SK_PAS_2008"
    case skPas2014 = "SK_PAS_2014"
    case skPas2008_14 = "SK_PAS_2008_14"
    case skDrv1993 = "SK_DRV_1993"
    case skDrv2004 = "SK_DRV_2004"
    case skDrv2008 = "SK_DRV_2008"
    case skDrv2009 = "SK_DRV_2009"
    case skDrv2013 = "SK_DRV_2013"
    case skDrv2015 = "SK_DRV_2015"
    case skDrv2004_08_09 = "SK_DRV_2004_08_09"
    case atIdentityCard2000 = "AT_IdentityCard_2000"
    case atIdc2002 = "AT_IDC_2002"
    case atIdc2005 = "AT_IDC_2005"
    case atIdc2010 = "AT_IDC_2010"
    case atPas2006 = "AT_PAS_2006"
    case atDrv2006 = "AT_DRV_2006"
    case atDrv2013 = "AT_DRV_2013"
    case plIdc2015 = "PL_IDC_2015"
    case deIdc2010 = "DE_IDC_2010"
    case deIdc2001 = "DE_IDC_2001"
    case hrIdc2013_15 = "HR_IDC_2013_15"
    case czRes2011_14 = "CZ_RES_2011_14"
    case czRes2006T = "CZ_RES_2006_T"
    case czRes2006_07 = "CZ_RES_2006_07"
    case czGun2016 = "CZ_GUN_2014"
    
    func isTypeOfDocument(type: DocumentType) -> Bool {
        let typeUpper = type.rawValue.uppercased()
        return self.rawValue.contains(typeUpper)
    }
    
    var documentType: DocumentType {
        get {
            for tp in [DocumentType.drivingLicence, .idCard, .passport] {
                if self.isTypeOfDocument(type: tp) {
                    return tp
                }
            }
            return .idCard // This shoudn't happen
        }
    }
}

enum PageCode: String, Decodable {
    case front = "F"
    case back = "B"
}

enum ValidatorCodes: Int {
    case selfie = 6
    case ministry = 19
}

struct Hash: Decodable {
    var AsText: String?
    var IsNull: Bool?
}

struct MineAllResult: Decodable {
    var FirstName: MinedText?
    var LastName: MinedText?
    var Address: MinedAddress?
    var BirthAddress: MinedText?
    var BirthLastName: MinedText?
    var BirthNumber: MinedRc?
    var BirthDate: MinedDate?
    var ExpiryDate: MinedDate?
    var IssueDate: MinedDate?
    var IdcardNumber: MinedText?
    var DrivinglicenseNumber: MinedText?
    var PassportNumber: MinedText?
    var Sex: MinedSex?
    var Nationality: MinedText?
    var Authority: MinedText?
    var MaritalStatus: MinedMaritalStatus?
    var Photo: MinedPhoto?
    var Mrz: MinedMrz?
    var DocumentCode: DocumentCode?
    var PageCode: PageCode?
    var Height: MinedText?
    var EyesColor: MinedText?
}

struct MinedText: Decodable {
    var Text: String?
    var Confidence: Int?
}

struct MinedAddress: Decodable {
    var A1: String?
    var A2: String?
    var A3: String?
    var AdministrativeAreaLevel1: String?
    var AdministrativeAreaLevel2: String?
    var Locality: String?
    var Sublocality: String?
    var Street: String?
    var HouseNumber: String?
    var StreetNumber: String?
    var PostalCode: String?
    var Text: String?
    var Confidence: Int?
}

struct MinedRc: Decodable {
    var BirthDate: String?
    var Checksum: Int?
    var Sex: String?
    var Text: String?
    var Confidence: Int?
}

struct MinedDate: Decodable {
    var Date: String?
    var Format: String?
    var Text: String?
    var Confidence: Int?
}

struct MinedSex: Decodable {
    var Sex: String?
    var Text: String?
    var Confidence: Int?
}

struct MinedMaritalStatus: Decodable {
    var MaritalStatus: String?
    var ImpliedSex: String?
    var Text: String?
    var Confidence: Int?
}

struct MinedPhoto: Decodable {
    var ImageData: LazyMatImage?
    var EstimatedAge: Int?
    var EstimatedSex: String?
    var Text: String?
    var Confidence: Int?
}

struct MinedMrz: Decodable {
    var Mrz: Mrz?
    var Text: String?
    var Confidence: Int?
}

struct LazyMatImage: Decodable {
    var ImageHash: Hash?
}

struct Mrz: Decodable {
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
