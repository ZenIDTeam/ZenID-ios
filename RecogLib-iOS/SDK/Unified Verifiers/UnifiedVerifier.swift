
import Foundation
import CoreVideo


public protocol UnifiedVerifier {
    func verify(image: CVPixelBuffer) -> UnifiedResult?
}
