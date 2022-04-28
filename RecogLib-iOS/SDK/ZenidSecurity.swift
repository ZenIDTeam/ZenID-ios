import Foundation

public final class ZenidSecurity {
    public static func getChallengeToken() -> String? {
        return StringUtils.AsString(RecogLib_iOS.getChallengeToken())
    }
        
    public static func authorize(responseToken: String) -> Bool {
        return RecogLib_iOS.authorize(responseToken.toUnsafeMutablePointer()!)
    }
    
    public static func isAuthorized() -> Bool {
        return RecogLib_iOS.isAuthorized()
    }
}
