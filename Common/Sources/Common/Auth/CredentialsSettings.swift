//
//  CredentialsSettings.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 10/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import Foundation

public final class CredentialsSettings: NSObject, NSCoding {
    private static let keyApiURL = "apiURL"
    private static let keyApiKey = "apiKey"

    public private(set) var apiURL: URL?
    public private(set) var apiKey: String?

    public init(apiURL: URL?, apiKey: String?) {
        self.apiURL = apiURL
        self.apiKey = apiKey
    }

    override convenience init() {
        self.init(apiURL: nil, apiKey: nil)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init()

        if aDecoder.containsValue(forKey: CredentialsSettings.keyApiURL) {
            apiURL = aDecoder.decodeObject(forKey: CredentialsSettings.keyApiURL) as? URL
        }
        if aDecoder.containsValue(forKey: CredentialsSettings.keyApiKey) {
            apiKey = aDecoder.decodeObject(forKey: CredentialsSettings.keyApiKey) as? String
        }
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(apiURL, forKey: CredentialsSettings.keyApiURL)
        aCoder.encode(apiKey, forKey: CredentialsSettings.keyApiKey)
    }
}
