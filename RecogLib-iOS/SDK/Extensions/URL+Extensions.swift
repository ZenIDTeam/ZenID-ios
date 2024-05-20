//
//  URL+Extensions.swift
//  RecogLib-iOS
//
//  Created by Vladimir Belohradsky on 15.05.2024.
//  Copyright © 2024 ZenID. All rights reserved.
//

import Foundation

extension URL {
    
    /// Create new URL by combining directory URL and file name.
    /// - Parameters:
    ///   - file: File name to be addded.
    ///   - directory: Directory URL.
    /// - Returns: New composite URL.
    func urlFor(file: String, in directory: URL) -> URL {
        return if #available(iOS 16.0, *) {
            directory.appending(path: file)
        } else {
            directory.appendingPathComponent(file)
        }
    }
    
}
