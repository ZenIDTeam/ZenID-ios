import UIKit

public enum RenderingPriority {
    case low
    case high
}

public protocol Renderable {
    
    var priority: RenderingPriority { get }
    
    init?(_ renderCommand: String)
    func draw(in ctx: CGContext)
}

extension Renderable {
    
    public var priority: RenderingPriority {
        .low
    }
}
