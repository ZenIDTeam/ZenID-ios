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
    case IDC1, IDC2, DRV, PAS, SK_IDC_2008plus, SK_DRV_2004_08_09, SK_DRV_2013, SK_DRV_2015, SK_PAS_2008_14, SK_IDC_1993, SK_DRV_1993, PL_IDC_2015, DE_IDC_2010, DE_IDC_2001, HR_IDC_2013_15, AT_IdentityCard_2000, AT_IDC_2002, AT_IDC_2005, AT_IDC_2010, AT_PAS_2006, AT_DRV_2006, AT_DRV_2013
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
    case Cz, Sk, At, Hu, Pl, De, Hr
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
    case NoMatchFound
    case TiltLeft
    case TiltRight
    case TiltUp
    case TiltDown
    case RotateClockwise
    case RotateCounterClockwise
    case Ok
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

public enum FaceStage: Int {
    case LookAtMe
    case TurnHead
    case Smile
    case Done
}

extension FaceStage: CustomStringConvertible {
    public var description: String {
        switch self {
        case .LookAtMe:
            return "Look at me"
        case .TurnHead:
            return "Turn head"
        case .Smile:
            return "Smile"
        case .Done:
            return "Done"
        }
    }
}
