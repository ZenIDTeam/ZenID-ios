//
//  CGPoint+Mirror.swift
//  ZenIDDemo
//
//  Created by Jiří Šácha on 25.02.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    func mirror(in rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.width - self.x, y: self.y)
    }
}

extension CGRect {
    func mirror(in rect: CGRect) -> CGRect {
        return CGRect(x: rect.width - self.minX - self.width,
                      y: self.minY,
                      width: width,
                      height: height)
    }
}
