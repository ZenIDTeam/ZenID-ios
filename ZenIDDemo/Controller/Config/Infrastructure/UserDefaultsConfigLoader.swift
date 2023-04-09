
import Foundation

final class UserDefaultsConfigLoader {
    private enum Keys: String {
        case debug = "IsDebugEnabled"
        case livenessMode = "IsLivenessVideo"
        case nfc = "IsNfcEnabled"
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultsConfigLoader: ConfigLoader {
    func load() -> Config {
        .init(
            isDebugEnabled: userDefaults.bool(forKey: Keys.debug.rawValue),
            isLivenessVideo: userDefaults.bool(forKey: Keys.livenessMode.rawValue),
            isNfcEnabled: userDefaults.bool(forKey: Keys.nfc.rawValue)
        )
    }
}

extension UserDefaultsConfigLoader: ConfigUpdater {
    func update(isDebugEnabled: Bool) throws {
        userDefaults.setValue(isDebugEnabled, forKey: Keys.debug.rawValue)
    }

    func update(isLivenessVideo: Bool) throws {
        userDefaults.setValue(isLivenessVideo, forKey: Keys.livenessMode.rawValue)
    }

    func update(isNfcEnabled: Bool) throws {
        userDefaults.setValue(isNfcEnabled, forKey: Keys.nfc.rawValue)
    }
}
