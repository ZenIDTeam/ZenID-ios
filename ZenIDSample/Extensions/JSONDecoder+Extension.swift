//
//  JSONDecoder+Extension.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 15.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation

extension JSONDecoder {
    nonisolated(unsafe) static var zenid: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromPascalCase
        return decoder
    }()
}

extension JSONDecoder.KeyDecodingStrategy {
    
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            // keys array is never empty
            let key = keys.last!
            // Do not change the key for an array
            guard key.intValue == nil else {
                return key
            }

            let codingKeyType = type(of: key)
            let newStringValue = key.stringValue.firstCharLowercased()

            return codingKeyType.init(stringValue: newStringValue)!
        }
    }
}
