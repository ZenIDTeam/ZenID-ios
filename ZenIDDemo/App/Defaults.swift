//
//  Defaults.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

final class Defaults {
    private static let defaults: UserDefaults = {
        let prefs = Bundle.main.path(forResource:"Settings", ofType: "plist")
        let defaults = UserDefaults.standard
        if let dict = NSDictionary(contentsOfFile: prefs!) as? Dictionary<String, AnyObject> {
            defaults.setValuesForKeys(dict)
            defaults.synchronize()
        }
        return defaults
    }()
    
    static var firstRun: Bool {
        get { return defaults[#function] ?? true }
        set { defaults[#function] = newValue }
    }
    
    static var credentialsSettings: CredentialsSettings {
        get {
            if let encodedData = defaults.data(forKey: #function) {
                let result = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData)
                let obj = result as? CredentialsSettings
                return obj ?? CredentialsSettings()
            }
            else {
                return CredentialsSettings()
            }
        }
        set {
            let encodedData: Data? = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: #function)
            defaults.synchronize()
        }
    }
}
