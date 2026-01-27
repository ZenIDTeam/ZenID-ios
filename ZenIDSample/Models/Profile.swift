//
//  Profile.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 16.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation

struct Profile {
        
    static var current: String {
        get {
            return UserDefaults.standard.string(forKey: "profile") ?? ""
        }
        set {
            if newValue == "" {
                UserDefaults.standard.removeObject(forKey: "profile")
            } else {
                UserDefaults.standard.set(newValue, forKey: "profile")
            }
            UserDefaults.standard.synchronize()
        }
    }
    
}
