import Foundation

final class StringUtils {
    static func AsString(_ cString: UnsafeMutablePointer<Int8>?) -> String? {
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
}
