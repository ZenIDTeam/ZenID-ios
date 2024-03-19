import Foundation
import UIKit

extension CGRect {
    
    func flipped() -> CGRect {
        return CGRect(x: origin.y, y: origin.x, width: height, height: width)
    }
    
    func rectThatFitsRect(_ rect: CGRect) -> CGRect {
        let sizeThatFits = self.size.sizeThatFitsSize(rect.size)

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
}
