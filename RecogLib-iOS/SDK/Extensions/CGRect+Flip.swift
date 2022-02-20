import Foundation
import UIKit

extension CGRect {
    func flip() -> CGRect {
        return CGRect(x: origin.y, y: origin.x, width: height, height: width)
    }
    
    func rectThatFitsRect(_ aRect: CGRect) -> CGRect {
        let sizeThatFits = self.size.sizeThatFitsSize(aRect.size)

        let xPos = (aRect.size.width - sizeThatFits.width) / 2
        let yPos = (aRect.size.height - sizeThatFits.height) / 2

        let ret = CGRect(x: xPos, y: yPos, width: sizeThatFits.width, height: sizeThatFits.height)
        return ret
    }
    
    func move(_ aPoint: CGPoint) -> CGRect {
        let ret = CGRect(x: self.origin.x + aPoint.x, y: self.origin.y + aPoint.y, width: self.width, height: self.height)
        return ret
    }
}
