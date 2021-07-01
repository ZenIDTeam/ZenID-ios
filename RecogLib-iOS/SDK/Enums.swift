//
//  DocumentEnums.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 01/07/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation

public enum SupportedLanguages: Int {
    case English
    case Czech
    case Polish
}

extension SupportedLanguages: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Czech:
            return "Cs"
        case .English:
            return "En"
        case .Polish:
            return "Pl"
        }
    }
}

public enum DocumentCode: Int {
    case IDC1 = 0
    case IDC2 = 1
    case DRV = 2
    case PAS = 3
    case SK_IDC_2008plus = 4
    case SK_DRV_2004_08_09 = 5
    case SK_DRV_2013 = 6
    case SK_DRV_2015 = 7
    case SK_PAS_2008_14 = 8
    case SK_IDC_1993 = 9
    case SK_DRV_1993 = 10
    case PL_IDC_2015 = 11
    case DE_IDC_2010 = 12
    case DE_IDC_2001 = 13
    case HR_IDC_2013_15 = 14
    case AT_IDE_2000 = 15
    case AT_IDC_2002_05_10 = 18
    case AT_PAS_2006_14 = 20
    case AT_DRV_2006 = 21
    case AT_DRV_2013 = 22
    case IT_PAS_2006_10 = 35
    case CZ_RES_2011_14 = 23
    case CZ_RES_2006_T = 24
    case CZ_RES_2006_07 = 25
    case CZ_RES_2020 = 33
    case CZ_GUN_2014 = 26
    case CZ_GUN_2017 = 32
<<<<<<< HEAD
    case EU_EHIC_2004_A = 30
    case EU_EHIC_2004_B = 55
=======
    case CZ_RES_2020 = 33
    case PL_IDC_2019 = 34
    case IT_PAS_2006_10 = 35
    case INT_ISIC_2008 = 36
    case DE_PAS = 37
    case DK_PAS = 38
    case ES_PAS = 39
    case FI_PAS = 40
    case FR_PAS = 41
    case GB_PAS = 42
    case IS_PAS = 43
    case NL_PAS = 44
    case RO_PAS = 45
    case SE_PAS = 46
    case PL_PAS = 47
    case PL_DRV_2013 = 48
    case CZ_BIRTH = 49
    case CZ_VEHICLE_I = 50
    case INT_ISIC_2019 = 51
    case SI_Pas = 52
    case SI_IDC = 53
    case SI_DRV = 54
    case EU_EHIC_2004_B = 55
    case PL_IDC_2001_02_13 = 56
>>>>>>> master2
}

extension DocumentCode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .IDC1:
            return "IDC1"
        case .IDC2:
            return "IDC2"
        case .DRV:
            return "DRV"
        case .PAS:
            return "PAS"
        case .SK_IDC_2008plus:
            return "SK_IDC_2008plus"
        case .SK_DRV_2004_08_09:
            return "SK_DRV_2004_08_09"
        case .SK_DRV_2013:
            return "SK_DRV_2013"
        case .SK_DRV_2015:
            return "SK_DRV_2015"
        case .SK_PAS_2008_14:
            return "SK_PAS_2008_14"
        case .SK_IDC_1993:
            return "SK_IDC_1993"
        case .SK_DRV_1993:
            return "SK_DRV_1993"
        case .PL_IDC_2015:
            return "PL_IDC_2015"
        case .DE_IDC_2010:
            return "DE_IDC_2010"
        case .DE_IDC_2001:
            return "DE_IDC_2001"
        case .HR_IDC_2013_15:
            return "HR_IDC_2013_15"
        case .AT_IDE_2000:
            return "AT_IDE_2000"
        case .AT_IDC_2002_05_10:
            return "AT_IDC_2002_05_10"
        case .AT_PAS_2006_14:
            return "AT_PAS_2006_14"
        case .AT_DRV_2006:
            return "AT_DRV_2006"
        case .AT_DRV_2013:
            return "AT_DRV_2013"
        case .IT_PAS_2006_10:
            return "IT_PAS_2006_10"
        case .CZ_RES_2011_14:
            return "CZ_RES_2011_14"
        case .CZ_RES_2006_T:
            return "CZ_RES_2006_T"
        case .CZ_RES_2006_07:
            return "CZ_RES_2006_07"
        case .CZ_RES_2020:
            return "CZ_RES_2020"
        case .CZ_GUN_2014:
            return "CZ_GUN_2014"
        case .CZ_GUN_2017:
            return "CZ_GUN_2017"
        case .EU_EHIC_2004_A:
            return "EU_EHIC_2004_A"
        case .EU_EHIC_2004_B:
            return "EU_EHIC_2004_B"
        }
    }
}

public enum PageCode: Int {
    case Front, Back
}

extension PageCode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Front:
            return "F"
        case .Back:
            return "B"
        }
    }
}

public enum Country: Int {
    case Cz = 0
    case Sk = 1
    case At = 2
    case Hu = 3
    case Pl = 4
    case De = 5
    case Hr = 6
    case It = 10
}

extension Country: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Cz:
            return "Cz"
        case .Sk:
            return "Sk"
        case .At:
            return "At"
        case .Hu:
            return "Hu"
        case .Pl:
            return "Pl"
        case .De:
            return "De"
        case .Hr:
            return "Hr"
        case .It:
            return "It"
        }
    }
}

public enum DocumentRole: Int {
    case Idc = 0
    case Pas = 1
    case Drv = 2
    case Res = 3
    case Gun = 4
    case Hic = 5
}

extension DocumentRole: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Idc:
            return "Idc"
        case .Drv:
            return "Drv"
        case .Pas:
            return "Pas"
        case .Res:
            return "Res"
        case .Gun:
            return "Gun"
        case .Hic:
            return "Hic"
        }
    }
}

public enum DocumentState: Int {
    case NoMatchFound = 0
    case AlignCard = 1
    case HoldSteady = 2
    case Blurry = 3
    case ReflectionPresent = 4
    case Ok = 5
    case Hologram = 6
    case Dark = 7
}

extension DocumentState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .NoMatchFound:
            return "No match found"
        case .AlignCard:
            return "Align card"
        case .HoldSteady:
            return "Hold steady"
        case .Blurry:
            return "Blurry"
        case .ReflectionPresent:
            return "Reflection present"
        case .Ok:
            return "Ok"
        case .Hologram:
            return "Hologram error"
        case .Dark:
            return "Too dark"
        }
    }
}

public enum HologramState: Int {
    case NoMatchFound = 0
    case TiltLeft = 1
    case TiltRight = 2
    case TiltUp = 3
    case TiltDown = 4
    case RotateClockwise = 5
    case RotateCounterClockwise = 6
    case Ok = 7
}

extension HologramState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .NoMatchFound:
            return "No match found"
        case .TiltLeft:
            return "Tilt left"
        case .TiltRight:
            return "Tilt right"
        case .TiltUp:
            return "Tilt up"
        case .TiltDown:
            return "Tilt down"
        case .RotateClockwise:
            return "Rotate clockwise"
        case .RotateCounterClockwise:
            return "Rotate counter clockwise"
        case .Ok:
            return "Ok"
        }
    }
}

public enum FaceLivenessState: Int {
    case LookAtMe = 0
    case TurnHead = 1
    case Smile = 2
    case Ok = 3
}

extension FaceLivenessState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .LookAtMe:
            return "Look at me"
        case .TurnHead:
            return "Turn head"
        case .Smile:
            return "Smile"
        case .Ok:
            return "Ok"
        }
    }
}

public enum SelfieState: Int {
    case Ok = 0
    case NoFaceFound = 1
    case Blurry = 2
    case Dark = 3
    case ConfirmingFace = 4
}

extension SelfieState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Ok:
            return "Ok"
        case .NoFaceFound:
            return "No face found"
        case .Blurry:
            return "Blurry"
        case .Dark:
            return "Dark"
        case .ConfirmingFace:
            return "Confirming face"
        }
    }
}
