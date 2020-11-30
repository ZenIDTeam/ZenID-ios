//
//  Credentials.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 11/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import Foundation

final class Credentials {
    
    public static let shared = Credentials()
    
    var apiURL: URL? {
        get { return Defaults.credentialsSettings.apiURL }
    }
    
    var apiKey: String? {
        get { return Defaults.credentialsSettings.apiKey }
    }

    private init() {}
    
    public func update(apiURL: URL, apiKey: String) {
        Defaults.credentialsSettings = CredentialsSettings(apiURL: apiURL, apiKey: apiKey)
    }
    
    public func clear() {
        Defaults.credentialsSettings = CredentialsSettings()
    }
    
    public func isValid() -> Bool {
        guard
            let apiKey = apiKey, !apiKey.isEmpty else {
            return false
        }
        guard
            let _ = apiURL else {
            return false
        }
        
        return true
    }
}
