//
//  LanguageHelper.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 26/06/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

final class LanguageHelper {
    static var language: SupportedLanguages {
        switch Locale.current.languageCode?.uppercased() {
        case "CS":
            return .Czech
        case "PL":
            return .Polish
        case "EN":
            return .English
        default:
            return .English
        }
    }
}
