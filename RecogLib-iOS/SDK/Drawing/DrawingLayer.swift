import UIKit

public class DrawingLayer: CALayer {
    
    var mirrorX = false
    
    private(set) var renderables: [Renderable]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.setNeedsDisplay()
            }
        }
    }
    
    override public func draw(in ctx: CGContext) {
        renderables?.forEach { $0.draw(in: ctx) }
    }
    
    public func setRenderables(_ renderables: [Renderable]?) {
        guard let renderables else {
            self.renderables = nil
            return
        }
        
        var high = [Renderable]()
        var low = [Renderable]()
        renderables.forEach { renderable in
            switch renderable.priority {
            case .high:
                high.append(renderable)
            case .low:
                low.append(renderable)
            }
        }
        self.renderables = high + low
    }
}
