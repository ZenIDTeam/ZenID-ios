import Foundation

extension CGSize {
    
    func flipped() -> CGSize {
        return CGSize(width: height, height: width)
    }
    
    func sizeThatFitsSize(_ size: CGSize) -> CGSize {
        let width = min(self.width * size.height / self.height, size.width)
        return CGSize(width: width, height: self.height * width / self.width)
    }
    
    func subscractHeight(_ value: CGFloat) -> CGSize {
        return CGSize(width: width, height: height - value)
    }
}
