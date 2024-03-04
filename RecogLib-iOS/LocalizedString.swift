import Foundation

public func LocalizedString(
    _ key: String,
    tableName: String? = nil,
    value: String = "",
    comment: String
) -> String {
    let value = NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: value, comment: comment)
    if value == key {
        return NSLocalizedString(key, tableName: nil, bundle: Bundle(for: DocumentVerifier.self), value: value, comment: comment)
    }
    
    return value
}
