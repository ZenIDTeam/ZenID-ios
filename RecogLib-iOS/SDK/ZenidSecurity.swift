import Foundation

public final class ZenidSecurity {
    public static func getChallengeToken() -> String? {
        StringUtils.AsString(RecogLib_iOS.getChallengeToken())
    }

    public static func authorize(responseToken: String) -> Bool {
        RecogLib_iOS.authorize(responseToken.toUnsafeMutablePointer()!)
    }

    public static func isAuthorized() -> Bool {
        RecogLib_iOS.isAuthorized()
    }

    public static func selectProfile(name: String) -> Bool {
        RecogLib_iOS.selectProfile(name)
    }

    public static let DEFAULT_PROFILE_NAME = ""
}
