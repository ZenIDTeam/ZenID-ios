//
//  String+localized.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 19/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

extension String {
    var localized : String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
}
