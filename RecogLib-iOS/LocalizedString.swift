import Foundation

public func LocalizedString(
    _ key: String,
    tableName: String? = nil,
    value: String = "",
    comment: String? = nil
) -> String {
    let value = NSLocalizedString(key, tableName: tableName, bundle: Bundle.main, value: value, comment: comment ?? key)
    if value == key {
        return NSLocalizedString(key, tableName: tableName, bundle: Bundle.recogLib, value: value, comment: comment ?? key)
    }
    
    return value
}
