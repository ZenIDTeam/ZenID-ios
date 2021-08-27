
import Foundation
import CoreVideo


protocol UnifiedVerifier {
    func verify(image: CVPixelBuffer) -> UnifiedResult?
}
