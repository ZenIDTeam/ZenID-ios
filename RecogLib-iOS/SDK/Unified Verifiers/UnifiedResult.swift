import Foundation

public protocol UnifiedResult {
    var state: UnifiedState { get }
    var role: RecogLib_iOS.DocumentRole? { get }
    var country: RecogLib_iOS.Country? { get }
    var code: RecogLib_iOS.DocumentCodes? { get }
    var page: RecogLib_iOS.PageCodes? { get }
    var signature: RecogLib_iOS.ImageSignature? { get }
}
