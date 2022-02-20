//
//  Triangle.swift
//  ZenIDDemo
//
//  Created by Libor on 13.12.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class Triangle: Renderable {
    private let aPoint: CGPoint
    private let bPoint: CGPoint
    private let cPoint: CGPoint
    private let color: CGColor
    private let thickness: CGFloat
    
    private var canFill: Bool {
        return thickness == -1
    }
    
    init?(_ renderCommand: String) {
        let values = RenderableFactory.split(command: renderCommand)
        let floatValues = RenderableFactory.floatsIn(splitCommand: values)
        
        guard floatValues.count == 11 else { return nil }
        
        aPoint = .init(x: floatValues[0], y: floatValues[1])
        bPoint = .init(x: floatValues[2], y: floatValues[3])
        cPoint = .init(x: floatValues[4], y: floatValues[5])
        
        color = UIColor(red:   floatValues[6] / 255.0,
                        green: floatValues[7] / 255.0,
                        blue:  floatValues[8] / 255.0,
                        alpha: floatValues[9] / 255.0).cgColor
        
        thickness = floatValues[10]
    }
    
    func draw(in ctx: CGContext) {
        ctx.move(to: aPoint)
        ctx.addLine(to: bPoint)
        ctx.addLine(to: cPoint)
        ctx.closePath()
        
        if canFill {
            ctx.setFillColor(color)
            let isAntialiasEnabled = color.alpha >= 1.0
            print(isAntialiasEnabled)
            ctx.setShouldAntialias(isAntialiasEnabled)
            ctx.setAllowsAntialiasing(isAntialiasEnabled)
            if isAntialiasEnabled {
                ctx.setBlendMode(.normal)
            } else {
                ctx.setBlendMode(.destinationAtop)
            }
            ctx.fillPath()
            ctx.setShouldAntialias(true)
            ctx.setAllowsAntialiasing(true)
        } else {
            ctx.setStrokeColor(color)
            ctx.setLineWidth(thickness)
            ctx.strokePath()
        }
    }
}
