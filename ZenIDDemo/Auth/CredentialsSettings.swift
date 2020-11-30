//
//  CredentialsSettings.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 10/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import Foundation

final class CredentialsSettings: NSObject, NSCoding {
    
    private static let keyApiURL = "apiURL"
    private static let keyApiKey = "apiKey"
    
    public private(set) var apiURL: URL?
    public private(set) var apiKey: String?
    
    init(apiURL: URL?, apiKey: String?) {
        self.apiURL = apiURL
        self.apiKey = apiKey
    }
    
    convenience override init() {
        self.init(apiURL: nil, apiKey: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        
        if aDecoder.containsValue(forKey: CredentialsSettings.keyApiURL) {
            self.apiURL = aDecoder.decodeObject(forKey: CredentialsSettings.keyApiURL) as? URL
        }
        if aDecoder.containsValue(forKey: CredentialsSettings.keyApiKey) {
            self.apiKey = aDecoder.decodeObject(forKey: CredentialsSettings.keyApiKey) as? String
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.apiURL, forKey: CredentialsSettings.keyApiURL)
        aCoder.encode(self.apiKey, forKey: CredentialsSettings.keyApiKey)
    }
}
