import Foundation
import UIKit.UIImage

public struct ImageSignature {
    
    public let image: Data
    
    public let signature: String
    
    /// Cropped image that fits given size proportions.
    ///
    /// - Note: Do not upload the image to the server!!! This is preview for UI only.
    public func croppedImagePreview(toFit size: CGSize) -> UIImage? {
        return UIImage(data: image)?.crop(useProportions: size)
    }
    
}
