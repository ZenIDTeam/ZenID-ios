import UIKit

public enum ZenFont {
    
    static let regular = "Roboto-Regular"
    
    static let bold = "Roboto-Bold"
    
    static let italic = "Roboto-Italic"
    
    static let black = "Roboto-Black"
}

public extension UIFont {
    
    static let dtitle = UIFont(name: ZenFont.black, size: 25) ?? UIFont.systemFont(ofSize: 25, weight: .black)
    
    static let darkTitle = UIFont(name: ZenFont.black, size: 25) ?? UIFont.systemFont(ofSize: 25, weight: .black)
    
    static let darkDescription = UIFont(name: ZenFont.regular, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular)
    
    static let buttonFont = UIFont(name: ZenFont.black, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .black)
    
    static let bigTitle = UIFont(name: ZenFont.black, size: 45) ?? UIFont.systemFont(ofSize: 45, weight: .black)
    
    static let title = UIFont(name: ZenFont.black, size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .black)
    
    static let version = UIFont(name: ZenFont.regular, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
    
    static let topLabel = UIFont(name: ZenFont.bold, size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
    
    static let messageLabel = UIFont(name: ZenFont.regular, size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
    
    static let pagesCountLabel = UIFont(name: ZenFont.bold, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
    
    static let resultTitle = UIFont(name: ZenFont.regular, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
    
    static let resultValue = UIFont(name: ZenFont.bold, size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
}
