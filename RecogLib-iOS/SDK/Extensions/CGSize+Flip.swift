import Foundation

extension CGSize {
    
    func flip() -> CGSize {
        return CGSize(width: height, height: width)
    }
    
    func sizeThatFitsSize(_ aSize: CGSize) -> CGSize {
        let width = min(self.width * aSize.height / self.height, aSize.width)
        return CGSize(width: width, height: self.height * width / self.width)
    }
}
