//
//  DocumentConfiguration.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 16.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID

/// DocumentConfiguration for verifiers.
struct DocumentConfiguration: Storable {
    
    // MARK: - This is used only for Document scanning.
    
    var country: Country
    
    var role: DocumentRole?
    
    var page: PageCodes?
    
}

extension DocumentConfiguration: @preconcurrency Codable {
    
    enum CodingKeys: String, CodingKey {
        case country
        case role
        case page
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        country = if let countryRaw = try container.decodeIfPresent(Int.self, forKey: .country) {
            Country(rawValue: countryRaw) ?? .cz
        } else { .cz }
        
        role = if let roleRaw = try container.decodeIfPresent(Int.self, forKey: .role) {
            DocumentRole(rawValue: roleRaw)
        } else { nil }
        
        page = if let pageRaw = try container.decodeIfPresent(Int.self, forKey: .page) {
            PageCodes(rawValue: pageRaw)
        } else { nil }
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(country.rawValue, forKey: .country)
        if let role {
            try container.encode(role.rawValue, forKey: .role)
        }
        if let page {
            try container.encode(page.rawValue, forKey: .page)
        }
        
    }
}
