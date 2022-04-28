import Foundation
import CoreGraphics

public protocol VerifierRenderable {
    func getRenderCommands(canvasSize: CGSize) -> String?
}
