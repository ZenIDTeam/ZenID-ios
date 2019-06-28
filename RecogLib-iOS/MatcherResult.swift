//
//  MatcherResult.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 27/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation

public enum DocumentCode: Int {
    case IDC1, IDC2, DRV, PAS, SK_IDC_2008plus, SK_DRV_2004_08_09, SK_DRV_2013, SK_DRV_2015, SK_PAS_2008_14, SK_IDC_1993, SK_DRV_1993, PL_IDC_2015, DE_IDC_2010, DE_IDC_2001, HR_IDC_2013_15, AT_IdentityCard_2000, AT_IDC_2002, AT_IDC_2005, AT_IDC_2010, AT_PAS_2006, AT_DRV_2006, AT_DRV_2013
}

public enum PageCode: Int { case F, B }

public enum Country: Int { case Cz, Sk, At, Hu, Pl, De, Hr }

public enum DocumentRole: Int { case Idc, Pas, Drv }

public enum DocumentState: Int { case NoMatchFound, AlignCard, HoldSteady, Blurry, ReflectionPresent, Ok }

public struct MatcherResult {
    public var role: DocumentRole
    public var country: Country
    public var code: DocumentCode?
    public var page: PageCode
    public var state: DocumentState
    
    init?(document: CDocumentInfo) {
        guard let role = DocumentRole(rawValue: Int(document.role)),
            let country = Country(rawValue: Int(document.country)),
            let page = PageCode(rawValue: Int(document.page)),
            let state = DocumentState(rawValue: Int(document.state)) else {
            return nil
        }
        self.page = page
        self.role = role
        self.code = DocumentCode(rawValue: Int(document.code))
        self.country = country
        self.state = state
    }
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
        }
    }
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

extension PageCode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .F:
            return "F"
        case .B:
            return "B"
        }
    }
}
