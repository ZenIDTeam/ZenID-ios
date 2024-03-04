import Foundation

extension String {
    
    func toUnsafeMutablePointer() -> UnsafeMutablePointer<Int8>? {
        return strdup(self)
    }
    
    /// Use this string as localisation key.
    var localised: String {
        LocalizedString(self, comment: self)
    }
}
