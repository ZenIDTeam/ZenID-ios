//
//  RecoglibMapper.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 01/07/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Common
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
}
