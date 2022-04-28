import UIKit

class Circle: Renderable {
    var center: CGPoint
    let radius: CGFloat
    let thickness: CGFloat
    let color: CGColor
    
    var rect: CGRect {
        return CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius),
                      size: CGSize(width: 2 * radius, height: 2 * radius))
    }
    
    var fill: Bool {
        return thickness < 0
    }
    
    required init?(_ renderCommand: String) {
        let values = RenderableFactory.split(command: renderCommand)
        let floatValues = RenderableFactory.floatsIn(splitCommand: values)
        
        guard floatValues.count == 8 else { return nil }
        
        self.center = CGPoint(x: floatValues[0], y: floatValues[1])
        
        self.radius = floatValues[2];
        
        self.color = UIColor(red:   floatValues[3] / 255,
                             green: floatValues[4] / 255,
                             blue:  floatValues[5] / 255,
                             alpha: floatValues[6] / 255).cgColor
        
        self.thickness = floatValues[7]
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
