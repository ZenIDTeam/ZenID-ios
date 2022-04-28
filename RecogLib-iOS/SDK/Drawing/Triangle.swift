import UIKit

final class Triangle: Renderable {
    var priority: RenderingPriority {
        .high
    }
    
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
            ctx.setStrokeColor(color)
            ctx.setLineWidth(1.0)
            ctx.setBlendMode(.copy)
            ctx.drawPath(using: .fillStroke)
        } else {
            ctx.setStrokeColor(color)
            ctx.setLineWidth(thickness)
            ctx.strokePath()
        }
    }
}
