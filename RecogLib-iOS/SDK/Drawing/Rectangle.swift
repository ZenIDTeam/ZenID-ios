import UIKit

class Rectangle: Renderable {
    
    var rect: CGRect
    
    let color: CGColor
    
    let thickness: CGFloat
    
    var fill: Bool {
        return thickness < 0
    }
    
    required init?(_ renderCommand: String) {
        let values = RenderableFactory.split(command: renderCommand)
        let floatValues = RenderableFactory.floatsIn(splitCommand: values)
        
        guard floatValues.count == 9 else { return nil }
                
        self.rect = CGRect(x: floatValues[0],
                           y: floatValues[1],
                           width: floatValues[2],
                           height: floatValues[3])
        
        self.color = UIColor(red:   floatValues[4] / 255,
                             green: floatValues[5] / 255,
                             blue:  floatValues[6] / 255,
                             alpha: floatValues[7] / 255).cgColor
        
        self.thickness = floatValues[8]
    }
    
    func draw(in ctx: CGContext) {
        if fill {
            ctx.setFillColor(color)
            ctx.fill(rect)
        }
        else {
            ctx.setStrokeColor(color)
            ctx.setLineWidth(self.thickness)
            ctx.addRect(rect)
            ctx.strokePath()
        }
    }
}
