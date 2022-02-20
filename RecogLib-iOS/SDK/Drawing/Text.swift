//
//  Text.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 17/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

enum TextVerticalAlignment: String {
    case top = "top"
    case center = "center"
    case bottom = "bottom"
}

enum TextHorizontalAlignment: String {
    case left = "left"
    case center = "center"
    case right = "right"
}

class Text: Renderable {
    var rect: CGRect
    let attributedString: NSAttributedString
    let font: UIFont = UIFont.topLabel
    
    required init?(_ renderCommand: String) {
        let values = RenderableFactory.split(command: renderCommand)
        let floatValues = RenderableFactory.floatsIn(splitCommand: values)
        guard values.count == 10, floatValues.count == 6 else { return nil }
        
        let color = UIColor(red:   floatValues[2] / 255,
                            green: floatValues[3] / 255,
                            blue:  floatValues[4] / 255,
                            alpha: floatValues[5] / 255)
        
        let textBg = UIColor.black.withAlphaComponent(0.3)
        
        let horizontalAlignment = TextHorizontalAlignment(rawValue: values[4]) ?? .center
        let verticalAlignment = TextVerticalAlignment(rawValue: values[5]) ?? .center
        
        attributedString = NSAttributedString(string: values[1],
                                              attributes: [.font: font,
                                                           .foregroundColor: color,
                                                           .backgroundColor: textBg])
        let size = attributedString.size()
        var originX = floatValues[0]
        var originY = floatValues[1]
        
        switch verticalAlignment {
        case .top:
            break
        case .center:
            originY -= size.height / 2
        case .bottom:
            originY -= size.height
        }
        
        switch horizontalAlignment {
        case .left:
            break
        case .center:
            originX -= size.width / 2
        case .right:
            originX -= size.width
        }
        
        self.rect = CGRect(origin: CGPoint(x: originX, y: originY), size: size).integral
    }
    
    func draw(in ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        attributedString.draw(in: rect)
        UIGraphicsPopContext()
    }
}
