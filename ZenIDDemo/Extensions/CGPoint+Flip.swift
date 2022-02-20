//
//  CGPoint+Flip.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 16/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    func flip() -> CGPoint {
        return CGPoint(x: y, y: x)
    }
}
