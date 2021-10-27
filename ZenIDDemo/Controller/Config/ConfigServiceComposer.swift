
import Foundation


final class ConfigServiceComposer {
    
    private static var service: ConfigService?
    
    static func compose() -> ConfigService {
        if service == nil {
            service = UserDefaultsConfigLoader()
        }
        return service!
    }
    
}
