//
//  Storable.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation

/// Class or struct that can be saved in `UserDefaults`.
@MainActor protocol Storable: Codable {}

@MainActor extension Storable {
        
    /// Save data.
    ///
    /// - Parameter key: Storage key.
    func save(key: String) throws {
        let data = try JSONEncoder().encode(self)
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /// Load data.
    /// - Parameter key: Storage key.
    /// - Returns: Restored object.
    static func load(key: String, defaultValue: Self? = nil) -> Self? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return defaultValue }
        
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {}
        
        return defaultValue
    }
}
