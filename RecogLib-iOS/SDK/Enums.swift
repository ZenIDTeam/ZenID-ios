//
//  DocumentEnums.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 01/07/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation

public enum SupportedLanguages: Int {
    case English = 0
    case Czech = 1
    case Polish = 2
    case German = 3
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
        case .German:
            return "De"
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
    case HU_IDC_2000_01_12 = 16
    case HU_IDC_2016 = 17
    case AT_IDC_2002_05_10 = 18
    case HU_ADD_2012 = 19
    case AT_PAS_2006_14 = 20
    case AT_DRV_2006 = 21
    case AT_DRV_2013 = 22
    case CZ_RES_2011_14 = 23
    case CZ_RES_2006_T = 24
    case CZ_RES_2006_07 = 25
    case CZ_GUN_2014 = 26
    case HU_PAS_2006_12 = 27
    case HU_DRV_2012_13 = 28
    case HU_DRV_2012_B = 29
    case EU_EHIC_2004_A = 30
    case Unknown = 31
    case CZ_GUN_2017 = 32
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
        default:
            return self.rawValue.description
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
    case Ro = 7
    case Ru = 8
    case Ua = 9
    case It = 10
    case Dk = 11
    case Es = 12
    case Fi = 13
    case Fr = 14
    case Gb = 15
    case Is = 16
    case Nl = 17
    case Se = 18
    case Si = 19
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
        case .Ro:
            return "Ro"
        case .Ru:
            return "Ru"
        case .Ua:
            return "Ua"
        case .It:
            return "It"
        case .Dk:
            return "Dk"
        case .Es:
            return "Es"
        case .Fi:
            return "Fi"
        case .Fr:
            return "Fr"
        case .Gb:
            return "Gb"
        case .Is:
            return "Is"
        case .Nl:
            return "Nl"
        case .Se:
            return "Se"
        case .Si:
            return "Si"
        }
    }
}

public enum DocumentRole: Int {
    case Idc, Pas, Drv
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
        }
    }
}

public enum DocumentState: Int {
    case NoMatchFound
    case AlignCard
    case HoldSteady
    case Blurry
    case ReflectionPresent
    case Ok
    case Hologram
    case Dark
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
