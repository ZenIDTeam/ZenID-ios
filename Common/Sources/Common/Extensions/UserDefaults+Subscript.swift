//
//  UserDefaults+Subscript.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 19/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

extension UserDefaults {
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}
