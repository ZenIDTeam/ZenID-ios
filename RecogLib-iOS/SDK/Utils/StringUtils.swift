//
//  StringUtils.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 10/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

final class StringUtils {
    static func AsString(_ cString: UnsafeMutablePointer<Int8>?) -> String? {
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
}
