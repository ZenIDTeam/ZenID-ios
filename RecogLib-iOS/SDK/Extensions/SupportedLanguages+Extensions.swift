//
//  SupportedLanguages+Extensions.swift
//  RecogLib-iOS
//
//  Created by Vladimir Belohradsky on 18.03.2024.
//  Copyright © 2024 ZenID. All rights reserved.
//

import Foundation

extension SupportedLanguages {
    
    /// Get current language.
    public static var current: SupportedLanguages {
        language(from: Locale.current)
    }
    
    /// Convert locale to SupportedLanguages option.
    public static func language(from locale: Locale) -> Self {
        let languageCode = if #available(iOS 16, *) {
            locale.language.languageCode?.identifier
        } else {
            locale.languageCode
        }
        
        return switch languageCode?.lowercased() {
        case "cs": .Czech
        case "de": .German
        case "pl": .Polish
        default: .English
        }
    }
}
