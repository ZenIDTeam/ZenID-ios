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
    case SI_PAS = 52
    case SI_IDC = 53
    case SI_DRV = 54
    case EU_EHIC_2004_B = 55
    case PL_IDC_2001_02_13 = 56
    case IT_IDC_2016 = 57
    case HR_PAS_2009_15 = 58
    case HR_DRV_2013 = 59
    case HR_IDC_2003 = 60
    case SI_DRV_2009 = 61
    case BG_PAS_2010 = 62
    case BG_IDC_2010 = 63
    case BG_DRV_2010_13 = 64
    case HR_IDC_2021 = 65
    case AT_IDC_2021 = 66
    case DE_PAS_2007 = 67
    case DE_DRV_2013_21 = 68
    case DE_DRV_1999_01_04_11 = 69
    case FR_IDC_2021 = 71
    case FR_IDC_1988_94 = 72
    case ES_PAS_2003_06 = 73
    case ES_IDC_2015 = 74
    case ES_IDC_2006 = 75
    case IT_IDC_2004 = 76
    case RO_IDC_2001_06_09_17_21 = 77
    case NL_IDC_2014_17_21 = 78
    case BE_PAS_2014_17_19 = 79
    case BE_IDC_2013_15 = 80
    case BE_IDC_2020_21 = 81
    case GR_PAS_2020 = 82
    case PT_PAS_2006_09 = 83
    case PT_PAS_2017 = 84
    case PT_IDC_2007_08_09_15 = 85
    case SE_IDC_2012_21 = 86
    case FI_IDC_2017_21 = 87
    case IE_PAS_2006_13 = 88
    case LT_PAS_2008_09_11_19 = 89
    case LT_IDC_2009_12 = 90
    case LV_PAS_2015 = 91
    case LV_PAS_2007 = 92
    case LV_IDC_2012 = 93
    case LV_IDC_2019 = 94
    case EE_PAS_2014 = 95
    case EE_PAS_2021 = 96
    case EE_IDC_2011 = 97
    case EE_IDC_2018_21 = 98
    case CY_PAS_2010_20 = 99
    case CY_IDC_2000_08 = 100
    case CY_IDC_2015_20 = 101
    case LU_PAS_2015 = 102
    case LU_IDC_2014_21 = 103
    case LU_IDC_2008_13 = 104
    case MT_PAS_2008 = 105
    case MT_IDC_2014 = 106
    case PL_PAS_2011 = 107
    case PL_DRV_1999 = 108
    case LT_IDC_2021 = 109
    case UA_PAS_2007_15 = 110
    case UA_IDC_2017 = 111
    case EU_VIS_2019 = 112
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
        case .HR_IDC_2021:
            return "HR_IDC_2021"
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
        case .PL_IDC_2019:
            return "PL_IDC_2019"
        case .PL_DRV_1999:
            return "PL_DRV_1999"
        case .INT_ISIC_2008:
            return "INT_ISIC_2008"
        case .DE_PAS:
            return "DE_PAS"
        case .DK_PAS:
            return "DK_PAS"
        case .ES_PAS:
            return "ES_PAS"
        case .FI_PAS:
            return "FI_PAS"
        case .FR_PAS:
            return "FR_PAS"
        case .GB_PAS:
            return "GB_PAS"
        case .IS_PAS:
            return "IS_PAS"
        case .NL_PAS:
            return "NL_PAS"
        case .RO_PAS:
            return "RO_PAS"
        case .SE_PAS:
            return "SE_PAS"
        case .PL_PAS:
            return "PL_PAS"
        case .PL_DRV_2013:
            return "PL_DRV_2013"
        case .CZ_BIRTH:
            return "CZ_BIRTH"
        case .CZ_VEHICLE_I:
            return "CZ_VEHICLE_I"
        case .INT_ISIC_2019:
            return "INT_ISIC_2019"
        case .SI_IDC:
            return "SI_IDC"
        case .SI_DRV:
            return "SI_DRV"
        case .PL_IDC_2001_02_13:
            return "PL_IDC_2001_02_13"
        case .LT_IDC_2021:
            return "LT_IDC_2021"
        case .HU_IDC_2000_01_12:
            return "HU_IDC_2000_01_12"
        case .HU_IDC_2016:
            return "HU_IDC_2016"
        case .HU_ADD_2012:
            return "HU_ADD_2012"
        case .HU_PAS_2006_12:
            return "HU_PAS_2006_12"
        case .HU_DRV_2012_13:
            return "HU_DRV_2012_13"
        case .HU_DRV_2012_B:
            return "HU_DRV_2012_B"
        case .SI_PAS:
            return "SI_PAS"
        case .IT_IDC_2016:
            return "IT_IDC_2016"
        case .HR_PAS_2009_15:
            return "HR_PAS_2009_15"
        case .HR_DRV_2013:
            return "HR_DRV_2013"
        case .HR_IDC_2003:
            return "HR_IDC_2003"
        case .SI_DRV_2009:
            return "SI_DRV_2009"
        case .BG_PAS_2010:
            return "BG_PAS_2010"
        case .BG_IDC_2010:
            return "BG_IDC_2010"
        case .BG_DRV_2010_13:
            return "BG_DRV_2010_13"
        case .AT_IDC_2021:
            return "AT_IDC_2021"
        case .DE_PAS_2007:
            return "DE_PAS_2007"
        case .DE_DRV_2013_21:
            return "DE_DRV_2013_21"
        case .DE_DRV_1999_01_04_11:
            return "DE_DRV_1999_01_04_11"
        case .FR_IDC_2021:
            return "FR_IDC_2021"
        case .FR_IDC_1988_94:
            return "FR_IDC_1988_94"
        case .ES_PAS_2003_06:
            return "ES_PAS_2003_06"
        case .ES_IDC_2015:
            return "ES_IDC_2015"
        case .ES_IDC_2006:
            return "ES_IDC_2006"
        case .IT_IDC_2004:
            return "IT_IDC_2004"
        case .RO_IDC_2001_06_09_17_21:
            return "RO_IDC_2001_06_09_17_21"
        case .NL_IDC_2014_17_21:
            return "NL_IDC_2014_17_21"
        case .BE_PAS_2014_17_19:
            return "BE_PAS_2014_17_19"
        case .BE_IDC_2013_15:
            return "BE_IDC_2013_15"
        case .BE_IDC_2020_21:
            return "BE_IDC_2020_21"
        case .GR_PAS_2020:
            return "GR_PAS_2020"
        case .PT_PAS_2006_09:
            return "PT_PAS_2006_09"
        case .PT_PAS_2017:
            return "PT_PAS_2017"
        case .PT_IDC_2007_08_09_15:
            return "PT_IDC_2007_08_09_15"
        case .SE_IDC_2012_21:
            return "SE_IDC_2012_21"
        case .FI_IDC_2017_21:
            return "FI_IDC_2017_21"
        case .IE_PAS_2006_13:
            return "IE_PAS_2006_13"
        case .LT_PAS_2008_09_11_19:
            return "LT_PAS_2008_09_11_19"
        case .LT_IDC_2009_12:
            return "LT_IDC_2009_12"
        case .LV_PAS_2015:
            return "LV_PAS_2015"
        case .LV_PAS_2007:
            return "LV_PAS_2007"
        case .LV_IDC_2012:
            return "LV_IDC_2012"
        case .LV_IDC_2019:
            return "LV_IDC_2019"
        case .EE_PAS_2014:
            return "EE_PAS_2014"
        case .EE_PAS_2021:
            return "EE_PAS_2021"
        case .EE_IDC_2011:
            return "EE_IDC_2011"
        case .EE_IDC_2018_21:
            return "EE_IDC_2018_21"
        case .CY_PAS_2010_20:
            return "CY_PAS_2010_20"
        case .CY_IDC_2000_08:
            return "CY_IDC_2000_08"
        case .CY_IDC_2015_20:
            return "CY_IDC_2015_20"
        case .LU_PAS_2015:
            return "LU_PAS_2015"
        case .LU_IDC_2014_21:
            return "LU_IDC_2014_21"
        case .LU_IDC_2008_13:
            return "LU_IDC_2008_13"
        case .MT_PAS_2008:
            return "MT_PAS_2008"
        case .MT_IDC_2014:
            return "MT_IDC_2014"
        case .PL_PAS_2011:
            return "PL_PAS_2011"
        case .UA_PAS_2007_15:
            return "UA_PAS_2007_15"
        case .UA_IDC_2017:
            return "UA_IDC_2017"
        case .EU_VIS_2019:
            return "EU_VIS_2019"
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
    case Bg = 20
    case Be = 23
    case Ee = 27
    case Ie = 28
    case Cy = 29
    case Lt = 31
    case Lv = 32
    case Lu = 33
    case Mt = 34
    case Pt = 38
    case Gr = 39
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
        case .Ro:
            return "Ro"
        case .Ru:
            return "Ru"
        case .Ua:
            return "Ua"
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
        case .Bg:
            return "Bg"
        case .Be:
            return "Be"
        case .Ee:
            return "Ee"
        case .Ie:
            return "Ie"
        case .Cy:
            return "Cy"
        case .Lt:
            return "Lt"
        case .Lv:
            return "Lv"
        case .Lu:
            return "Lu"
        case .Mt:
            return "Mt"
        case .Pt:
            return "Pt"
        case .Gr:
            return "Gr"
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
    case Vis = 11
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
        case .Vis:
            return "Vis"
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
    case Barcode = 8
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
        case .Barcode:
            return "Barcode not readable"
        }
    }
}

public enum HologramState: Int {
    case center = 0
    case tiltLeftAndRight = 1
    case tiltUpAndDown = 2
    case ok = 3
}

extension HologramState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .center:
            return "Center"
        case .tiltLeftAndRight:
            return "Tilt left and right"
        case .tiltUpAndDown:
            return "Tilt up and down"
        case .ok:
            return "Ok"
        }
    }
}

public enum FaceLivenessState: Int {
    case LookAtMe = 0
    case TurnHead = 1
    case Smile = 2
    case Ok = 3
    case blurry = 4
    case dark = 5
    case holdStill = 6
}

extension FaceLivenessState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .LookAtMe:
            return "Look at the camera"
        case .TurnHead:
            return "Turn head slowly towards arrow"
        case .Smile:
            return "Smile"
        case .Ok:
            return "Ok"
        case .blurry:
            return "Blurry"
        case .dark:
            return "Dark"
        case .holdStill:
            return "Hold Still"
        }
    }
}

public enum SelfieState: Int {
    case Ok = 0
    case NoFaceFound = 1
    case Blurry = 2
    case Dark = 3
    case ConfirmingFace = 4
    case badFaceAngle = 5
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
        case .badFaceAngle:
            return "Bad face angle"
        }
    }
}
