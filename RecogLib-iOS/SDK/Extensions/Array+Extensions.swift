//
//  Array+Extensions.swift
//  RecogLib-iOS
//
//  Created by Vladimir Belohradsky on 01.02.2024.
//  Copyright © 2024 Marek Stana. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    
    var uniqueValues: [Element] {
        var allowed = Set(self)
        return compactMap { allowed.remove($0) }
    }
}
