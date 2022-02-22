
import Foundation
import RecogLib_iOS


public protocol UnifiedResult {
    var state: UnifiedState { get }
    var role: RecogLib_iOS.DocumentRole? { get }
    var country: RecogLib_iOS.Country? { get }
    var code: RecogLib_iOS.DocumentCode? { get }
    var page: RecogLib_iOS.PageCode? { get }
    var signature: RecogLib_iOS.ImageSignature? { get }
}
