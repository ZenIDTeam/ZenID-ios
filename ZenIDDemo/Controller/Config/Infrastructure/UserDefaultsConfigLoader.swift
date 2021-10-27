
import Foundation


final class UserDefaultsConfigLoader {
    private enum Keys: String {
        case debug = "IsDebugEnabled"
    }
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsConfigLoader: ConfigLoader {
    func load() -> Config {
        .init(isDebugEnabled: userDefaults.bool(forKey: Keys.debug.rawValue))
    }
}

extension UserDefaultsConfigLoader: ConfigUpdater {
    func update(isDebugEnabled: Bool) throws {
        userDefaults.setValue(isDebugEnabled, forKey: Keys.debug.rawValue)
    }
}
