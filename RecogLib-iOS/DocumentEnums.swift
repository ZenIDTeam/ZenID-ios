//
//  DocumentEnums.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 01/07/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation

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

