//
//  String+Extensions.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 10/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

extension String {
    func toUnsafeMutablePointer() -> UnsafeMutablePointer<Int8>? {
        return strdup(self)
    }
}
