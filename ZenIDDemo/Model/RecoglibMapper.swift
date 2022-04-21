//
//  RecoglibMapper.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 01/07/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

final class RecoglibMapper {

    static func documentRole(from type: DocumentType, role: RecogLib_iOS.DocumentRole? = nil) -> RecogLib_iOS.DocumentRole? {
        switch type {
        case .idCard:
            return DocumentRole.Idc
        case .drivingLicence:
            return DocumentRole.Drv
        case .passport:
            return DocumentRole.Pas
        case .unspecifiedDocument:
            return nil
        case .otherDocument:
            return nil
        case .face:
            return nil
        case .filter:
            return role
        case .documentVideo:
            return nil
        }
    }

    static func pageCode(from photoType: PhotoType) -> RecogLib_iOS.PageCode? {
        switch photoType {
        case .front:
            return .Front
        case .back:
            return .Back
        case .face:
            return nil
        }
    }
    
    static func country(from country: Country) -> RecogLib_iOS.Country? {
        switch country {
        case .cz:
            return .Cz
        case .sk:
            return .Sk
        case .at:
            return .At
        case .hu:
            return .Hu
        case .pl:
            return .Pl
        case .de:
            return .De
        case .hr:
            return .Hr
        case .ro:
            return .Ro
        case .ru:
            return .Ru
        case .ua:
            return .Ua
        case .it:
            return .It
        case .dk:
            return .Dk
        case .es:
            return .Es
        case .fi:
            return .Fi
        case .fr:
            return .Fr
        case .gb:
            return .Gb
        case .is:
            return .Is
        case .nl:
            return .Nl
        case .se:
            return .Se
        case .si:
            return .Si
        case .bg:
            return .Bg
        case .be:
            return .Be
        case .ee:
            return .Ee
        case .ie:
            return .Ie
        case .cy:
            return .Cy
        case .lt:
            return .Lt
        case .lv:
            return .Lv
        case .lu:
            return .Lu
        case .mt:
            return .Mt
        case .pt:
            return .Pt
        case .gr:
            return .Gr
        }
    }
}
