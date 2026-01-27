//
//  String+Extension.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation

extension String {
    
    /// App version and bundle number.
    static var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        
        return "\(version) (\(build))"
    }
    
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
    
}
