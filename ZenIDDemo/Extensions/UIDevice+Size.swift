//
//  UIDevice+Size.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 27/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

extension UIDevice {
    static var isPhoneSE: Bool {
        get {
            return UIScreen.main.nativeBounds.height < 1334
        }
    }
}
