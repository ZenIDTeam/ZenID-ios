
import Foundation


typealias ConfigService = ConfigLoader & ConfigUpdater

protocol ConfigLoader {
    func load() -> Config
}

protocol ConfigUpdater {
    func update(isDebugEnabled: Bool) throws
    func update(isLivenessVideo: Bool) throws
    func update(isNfcEnabled: Bool) throws
}
