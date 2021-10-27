
import Foundation


typealias ConfigService = ConfigLoader & ConfigUpdater

protocol ConfigLoader {
    func load() -> Config
}

protocol ConfigUpdater {
    func update(isDebugEnabled: Bool) throws
}
