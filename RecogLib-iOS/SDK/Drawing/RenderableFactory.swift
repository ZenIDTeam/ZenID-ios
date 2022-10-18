import UIKit

public enum RenderableType: String {
    case line = "line"
    case rectangle = "rectangle"
    case circle = "circle"
    case ellipse = "ellipse"
    case text = "text"
    case triangle = "triangle"
}

public class RenderableFactory {
    public static func createRenderables(commands: String) -> [Renderable] {
        //ApplicationLogger.shared.Debug("Render:\n\(commands)")
        return commands
            .split(separator: "\n")
            .compactMap(createRenderable(command:))
    }
        
    public static func createRenderable<T>(command: T) -> Renderable? where T: StringProtocol {
        let strCommand = String(command)
        guard let type = strCommand.split(separator: ";").first else { return nil }
        
        switch RenderableType(rawValue: String(type)) {
        case .line:
            return Line(strCommand)
        case .rectangle:
            return Rectangle(strCommand)
        case .circle:
            return Circle(strCommand)
        case .ellipse:
            return Ellipse(strCommand)
        case .text:
            return Text(strCommand)
        case .triangle:
            return Triangle(strCommand)
            
        default:
            return nil
        }
    }
}

extension RenderableFactory {
    static func split(command: String) -> [String] {
        command.split(separator: ";").map { String($0) }
    }
    
    static func floatsIn(splitCommand: [String]) -> [CGFloat] {
        splitCommand.compactMap { str -> CGFloat? in
            if let flValue = Float(str) {
                return CGFloat(flValue)
            }
            return nil
        }
    }
}
