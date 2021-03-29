//
//  SessionManager.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

final class Manager {
    
    /// Global configuration for the URLSession. Stores backend api key in cookies.
    public static var configuration: URLSessionConfiguration = {
        guard let apiKey = Credentials.shared.apiKey, !apiKey.isEmpty else {
            Log.shared.Error("Missing API key. Please get API key from backend developer and save it in Settings.plist!")
            fatalError("Missing API key. Please get API key from backend developer and save it in Settings.plist!")
        }
        guard let apiURL = Credentials.shared.apiURL else {
            Log.shared.Error("Malformed API URL!")
            fatalError("Malformed API URL!")
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 600
        configuration.timeoutIntervalForResource = 600
        
        if let cookie = HTTPCookie(properties: [HTTPCookiePropertyKey.name : "api_key",
                                                HTTPCookiePropertyKey.value : apiKey,
                                                HTTPCookiePropertyKey.originURL : apiURL,
                                                HTTPCookiePropertyKey.path : apiURL.path ]) {
            configuration.httpCookieStorage?.setCookie(cookie)
        }
        
        return configuration
    }()
}
