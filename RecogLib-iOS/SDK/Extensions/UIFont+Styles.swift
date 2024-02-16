import UIKit

public enum ZenFont {
    
    static let regular = "Roboto-Regular"
    
    static let bold = "Roboto-Bold"
    
    static let italic = "Roboto-Italic"
    
    static let black = "Roboto-Black"
}

public extension UIFont {
    
    static let dtitle = UIFont(name: ZenFont.black, size: 25)!
    
    static let darkTitle = UIFont(name: ZenFont.black, size: 25)!
    
    static let darkDescription = UIFont(name: ZenFont.regular, size: 18)!
    
    static let buttonFont = UIFont(name: ZenFont.black, size: 14)!
    
    static let bigTitle = UIFont(name: ZenFont.black, size: 45)!
    
    static let title = UIFont(name: ZenFont.black, size: 30)!
    
    static let version = UIFont(name: ZenFont.regular, size: 14)!
    
    static let topLabel = UIFont(name: ZenFont.bold, size: 17)!
    
    static let messageLabel = UIFont(name: ZenFont.regular, size: 15)!
    
    static let pagesCountLabel = UIFont(name: ZenFont.bold, size: 18)!
    
    static let resultTitle = UIFont(name: ZenFont.regular, size: 14)!
    
    static let resultValue = UIFont(name: ZenFont.bold, size: 20)!
}
