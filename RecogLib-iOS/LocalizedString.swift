import Foundation

public func LocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
    NSLocalizedString(key, tableName: nil, bundle: Bundle(for: Camera.self), value: value, comment: comment)
}
