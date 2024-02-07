import Foundation
import OSLog

public final class ZenidSecurity {
        
    /// Get challenge token from network service.
    ///
    /// - Returns: Produce string with challenge token required for authorization.
    public static func getChallengeToken() -> String? {
        StringUtils.AsString(RecogLib_iOS.getChallengeToken())
    }
    
    /// Authorize with challenge token.
    ///
    /// Token is retrived from server side service by calling `initSDK` function.
    ///
    /// - Parameter responseToken: Authorization token.
    /// - Returns: Produce `True` when authorization was successful.
    public static func authorize(responseToken: String) -> Bool {
        RecogLib_iOS.authorize(responseToken.toUnsafeMutablePointer()!)
    }
    
    /// Ask ZenID if library is authorized and can be used.
    ///
    /// - Returns: Produce `True` when authorization is valid.
    public static func isAuthorized() -> Bool {
        RecogLib_iOS.isAuthorized()
    }
    
    
    /// Select supported profile.
    ///
    /// Necessary to enable NFC functionality.
    /// See: `DEFAULT_PROFILE_NAME` and `NFC_PROFILE_NAME`
    ///
    /// - Parameter name: Name of profile.
    /// - Returns: Produce `True` when the profile is successfuly selected.
    public static func selectProfile(name: String) -> Bool {
        RecogLib_iOS.selectProfile(name)
    }
        
    /// List of supported countries enabled by Licence.
    ///
    /// - Returns: Array of `Country`.
    public static func supportedCountries() -> [Country]? {
        if let json = StringUtils.AsString(RecogLib_iOS.getEnabledFeaturesJson())?.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                    if let documents = json["Documents"] as? [[String: Any]] {
                        return documents.compactMap { document in
                            return if let country = document["Country"] as? Int {
                                Country(rawValue: country)
                            } else {
                                nil
                            }
                        }.uniqueValues
                    }
                }
            } catch let error {
                os_log(.error, "Failed to load: %@", error.localizedDescription)
            }
        }
        
        return nil
    }
    
    /// List of supported documents from given country enabled by Licence.
    ///
    /// - Parameter country: Country of issue.
    /// - Returns: Array of `DocumentRole`.
    public static func supportedDocuments(for country: Country) -> [DocumentRole]? {
        if let json = StringUtils.AsString(RecogLib_iOS.getEnabledFeaturesJson())?.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                    if let documents = json["Documents"] as? [[String: Any]] {
                        return documents.compactMap { document in
                            return if let countryRaw = document["Country"] as? Int,
                                      Country(rawValue: countryRaw) == country,
                                      let documentRole = document["DocumentRole"] as? Int
                            {
                                DocumentRole(rawValue: documentRole)
                            } else {
                                nil
                            }
                        }.uniqueValues
                    }
                }
            } catch let error {
                os_log(.error, "Failed to load: %@", error.localizedDescription)
            }
        }
        
        return nil
    }
    
    /// List of supported pages for document from given country enabled by Licence.
    /// - Parameters:
    ///   - country: Country of issue.
    ///   - documentRole: Document role.
    /// - Returns: Array of `PageCodes`.
    public static func supportedDocumentPageCodes(for country: Country, documentRole: DocumentRole) -> [PageCodes]? {
        if let json = StringUtils.AsString(RecogLib_iOS.getEnabledFeaturesJson())?.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                    if let documents = json["Documents"] as? [[String: Any]] {
                        return documents.compactMap { document in
                            return if let countryRaw = document["Country"] as? Int,
                                      Country(rawValue: countryRaw) == country,
                                      let documentRoleRaw = document["DocumentRole"] as? Int,
                                      DocumentRole(rawValue: documentRoleRaw) == documentRole,
                                      let pageCodeRaw = document["PageCode"] as? Int
                            {
                                PageCodes(rawValue: pageCodeRaw)
                            } else {
                                nil
                            }
                        }.uniqueValues
                    }
                }
            } catch let error {
                os_log(.error, "Failed to load: %@", error.localizedDescription)
            }
        }
        
        return nil
    }
    
    /// Default scanning profile.
    public static let DEFAULT_PROFILE_NAME = ""
    
    /// NFC scanning profile.
    public static let NFC_PROFILE_NAME = "NFC"
}
