//
//  IdentifiableScreen.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation

protocol IdentifiableScreen: Hashable {
    
    static var navigationIdentifier: UUID { get }
    
}

extension IdentifiableScreen {
    
    nonisolated static func == (lhs: Self, rhs: Self) -> Bool {
        Self.navigationIdentifier == Self.navigationIdentifier
    }
        
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(Self.navigationIdentifier)
    }
    
    static var navigationIdentifier: UUID {
        return UUID()
    }
}
