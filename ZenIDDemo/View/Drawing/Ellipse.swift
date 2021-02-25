//
//  Ellipse.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 27/09/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import UIKit

class Ellipse: Renderable {
    var center: CGPoint
    let radiusX: CGFloat
    let radiusY: CGFloat
    let rotation: CGFloat // ellipse rotation not implemented
    let thickness: CGFloat
    let color: CGColor
    
    var rect: CGRect {
        return CGRect(origin: CGPoint(x: center.x - radiusX, y: center.y - radiusY),
                      size: CGSize(width: 2 * radiusX, height: 2 * radiusY))
    }
    
    var fill: Bool {
        return thickness < 0
    }
    
    required init?(_ renderCommand: String) {
        let values = RenderableFactory.split(command: renderCommand)
        let floatValues = RenderableFactory.floatsIn(splitCommand: values)
        
        guard floatValues.count == 10 else { return nil }
        
        self.center = CGPoint(x: floatValues[0], y: floatValues[1])
        
        radiusX = floatValues[2];
        radiusY = floatValues[3];
        rotation = floatValues[4];
        
        self.color = UIColor(red:   floatValues[5] / 255,
                             green: floatValues[6] / 255,
                             blue:  floatValues[7] / 255,
                             alpha: floatValues[6] / 255).cgColor
        
        self.thickness = floatValues[9]
    }
    
    func mirror(in frame: CGRect) -> Renderable {
        self.center = center.mirror(in: frame)
        return self
    }
    
    func draw(in ctx: CGContext) {
        if fill {
            ctx.setFillColor(color)
            ctx.fillEllipse(in: rect)
        }
        else {
            ctx.setStrokeColor(color)
            ctx.setLineWidth(self.thickness)
            ctx.addEllipse(in: rect)
            ctx.strokePath()
        }
    }
}
