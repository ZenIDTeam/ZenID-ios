import UIKit

enum RenderingPriority {
    case low
    case high
}

protocol Renderable {
    var priority: RenderingPriority { get }
    
    init?(_ renderCommand: String)
    func draw(in ctx: CGContext)
}

extension Renderable {
    var priority: RenderingPriority {
        .low
    }
}
