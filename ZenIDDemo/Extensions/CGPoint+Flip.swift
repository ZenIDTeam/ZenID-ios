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

extension CGSize {
    func flip() -> CGSize {
        return CGSize(width: height, height: width)
    }
    
    func sizeThatFitsSize(_ aSize: CGSize) -> CGSize
    {
        let width = min(self.width * aSize.height / self.height, aSize.width)
        return CGSize(width: width, height: self.height * width / self.width)
    }
}

extension CGRect {
    func flip() -> CGRect {
        return CGRect(x: origin.y, y: origin.x, width: height, height: width)
    }
    
    func rectThatFitsRect(_ aRect:CGRect) -> CGRect
    {
        let sizeThatFits = self.size.sizeThatFitsSize(aRect.size)

        let xPos = (aRect.size.width - sizeThatFits.width) / 2
        let yPos = (aRect.size.height - sizeThatFits.height) / 2

        let ret = CGRect(x: xPos, y: yPos, width: sizeThatFits.width, height: sizeThatFits.height)
        return ret
    }
}
