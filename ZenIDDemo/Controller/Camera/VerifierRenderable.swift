
import Foundation
import CoreGraphics


protocol VerifierRenderable {
    func getRenderCommands(canvasSize: CGSize) -> String?
}
