//
//  MatcherResult.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 27/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation

enum DocumentCodes: Int {
    case IDC1, IDC2, DRV, PAS, SK_IDC_2008plus, SK_DRV_2004_08_09, SK_DRV_2013, SK_DRV_2015, SK_PAS_2008_14, SK_IDC_1993, SK_DRV_1993, PL_IDC_2015, DE_IDC_2010, DE_IDC_2001, HR_IDC_2013_15, AT_IdentityCard_2000, AT_IDC_2002, AT_IDC_2005, AT_IDC_2010, AT_PAS_2006, AT_DRV_2006, AT_DRV_2013
}

enum PageCodes: Int {
    case F, B
}

enum Country: Int {
    case Cz, Sk, At, Hu, Pl, De, Hr
}

enum DocumentRole: Int {
    case Idc, Pas, Drv
}

struct MatcherResult {
    var documentRole: DocumentRole
    var documentCountry: Country
    var documentCode: DocumentCodes
    var documentPage: PageCodes
    var state: Int
}

class CMatcherResultWrapper {
    private var pointer: OpaquePointer?
    
    var result: MatcherResult? {
//        return MatcherResult()
        return nil
    }
    
    init() {
//        pointer = initMatcherResult()
    }
    
    deinit {
//        delete_pointer(pointer)
    }
}
