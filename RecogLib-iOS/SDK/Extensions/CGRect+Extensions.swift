import Foundation
import UIKit

extension CGRect {
    
    func flipped() -> CGRect {
        return CGRect(x: origin.y, y: origin.x, width: height, height: width)
    }
    
    func rectThatFitsRect(_ rect: CGRect) -> CGRect {
        let sizeThatFits = self.size.thatFits(size: rect.size)

        let xPos = (rect.size.width - sizeThatFits.width) / 2
        let yPos = (rect.size.height - sizeThatFits.height) / 2

        let ret = CGRect(x: xPos, y: yPos, width: sizeThatFits.width, height: sizeThatFits.height)
        return ret
    }
    
    func moved(_ point: CGPoint) -> CGRect {
        let ret = CGRect(x: self.origin.x + point.x, 
                         y: self.origin.y + point.y,
                         width: self.width,
                         height: self.height)
        return ret
    }
    
    func substractFromTop(_ value: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY + value, width: width, height: height - value)
    }
    
    func multipledBy(_ value: CGFloat) -> CGRect {
        return CGRect(x: round(minX * value) ,
                      y: round(minY * value),
                      width: round(width * value),
                      height: round(height * value))
    }
    
    
    /// This function crop this rect to fill target rect. Then it can apply another crop that is represented in
    /// target rect coordinates.
    ///
    /// This function was created to help crop video to match UI view port.
    ///
    /// - Parameters:
    ///   - targetRect: Target rect.
    ///   - crop: Crop rect that is represented in target rect coordinates.
    /// - Returns: Cropped rect in source coordinates.
    func toFill(_ targetRect: CGRect, thenCrop crop: CGRect?) -> CGRect {
        // Calculate aspect ratios
        let sourceAspectRatio = self.width / self.height
        let targetAspectRatio = targetRect.width / targetRect.height
        
        var result = CGRect.zero
        
        // Determine the scaling factor and size
        if sourceAspectRatio > targetAspectRatio {
            // Source is wider than target
            let scale = height / targetRect.height
            let width = targetRect.width * scale
            let x = (self.width - width) / 2
            
            result = if let cropRect = crop?.multipledBy(scale) {
                CGRect(x: x + cropRect.minX,
                       y: 0 + cropRect.minY,
                       width: cropRect.width,
                       height: cropRect.height)
            } else {
                CGRect(x: x, y: 0, width: width, height: height)
            }
            
        } else {
            // Source is taller than target
            let scale = width / targetRect.width
            let height = targetRect.height * scale
            let y = (self.height - height) / 2
            
            result = if let cropRect = crop?.multipledBy(scale) {
                CGRect(x: 0 + cropRect.minX,
                       y: y + cropRect.minY,
                       width: cropRect.width,
                       height: cropRect.height)
            } else {
                CGRect(x: 0, y: y, width: width, height: height)
            }
        }
        
        // If crop start outside video boundary then don't crop at all.
        guard
            (0...width).contains(result.minX),
            (0...height).contains(result.minY)
        else {
            return self
        }
        
        // If width exceed then trim it to video boundary
        if !(0...width).contains(result.minX + result.width) {
            result = CGRect(x: result.minX, y: result.minY, width: width - result.minX, height: result.height)
        }
        
        // If height exceed then trim it to video boundary
        if !(0...height).contains(result.minY + result.height) {
            result = CGRect(x: result.minX, y: result.minY, width: result.width, height: height - result.minY)
        }
        
        return result
    }
}
