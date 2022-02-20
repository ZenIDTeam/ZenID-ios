//
//  Line.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 16/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

class Line: Renderable {
    var a: CGPoint
    var b: CGPoint
    let color: CGColor
    let thickness: CGFloat
    
    required init?(_ renderCommand: String) {
        let values = RenderableFactory.split(command: renderCommand)
        let floatValues = RenderableFactory.floatsIn(splitCommand: values)
        
        guard floatValues.count == 9 else { return nil }
        
        self.a = CGPoint(x: floatValues[0], y: floatValues[1])
        self.b = CGPoint(x: floatValues[2], y: floatValues[3])
                
        self.color = UIColor(red:   floatValues[4] / 255,
                             green: floatValues[5] / 255,
                             blue:  floatValues[6] / 255,
                             alpha: floatValues[7] / 255).cgColor
        
        self.thickness = floatValues[8]
    }
    
    func draw(in ctx: CGContext) {
        ctx.setStrokeColor(color)
        ctx.setLineWidth(self.thickness)
        
        ctx.beginPath()
        ctx.move(to: self.a)
        ctx.addLine(to: self.b)
        ctx.strokePath()
    }    
}
