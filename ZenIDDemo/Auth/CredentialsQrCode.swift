//
//  CredentialsQrCode.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 11/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import Foundation

final class CredentialsQrCode {
    private let EMPTY_CHAR: Character = " "
    
    public private(set) var apiURL: URL?
    public private(set) var apiKey: String?
    public var isValid: Bool { return apiURL != nil && apiKey != nil }
    
    init?(value: String) {
        if !value.contains(EMPTY_CHAR) {
            return nil
        }
        
        let parts = value.split(separator: EMPTY_CHAR)
        if parts.count < 2 {
            return nil
        }
        
        apiURL = URL(string: String(parts[0]))
        apiKey = String(parts[1])
        if apiURL == nil || apiKey!.count < 1 {
            return nil
        }
    }
}
