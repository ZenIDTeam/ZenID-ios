import Common
import Foundation
import RecogLib_iOS

class AuthManager {
    static func ensureCredentials(completion: (() -> Void)? = nil) {
        if Credentials.shared.isValid() {
            if let completion = completion {
                zenidAuthorize(completion: { _ in
                    DispatchQueue.main.async {
                        completion()
                    }
                })
            }
            return
        }
        
        // TODO: handle not authorized
    }
    
    static func zenidAuthorize(completion: @escaping ((Bool) -> Void)) {
        let isAuthorized = ZenidSecurity.isAuthorized()
        ApplicationLogger.shared.Verbose("ZenidSecurity: isAuthorized: \(String(isAuthorized))")

        if isAuthorized {
            completion(true)
            return
        }

        let errorMessage: (() -> Void) = {
            DispatchQueue.main.async {
                print("Authorization error")
                //self?.alert(title: "title-error".localized, message: "alert-authorization-failed".localized)
            }
        }
        
        if let challengeToken = ZenidSecurity.getChallengeToken() {
            Client()
                .request(API.initSdk(token: challengeToken)) { response, _ in
                    if let response = response, let responseToken = response.Response {
                        // TODO: not authorized with valid token ??????
                        //let authorizeX = ZenidSecurity.authorize(responseToken: responseToken)
                        let authorize = true
                        ApplicationLogger.shared.Verbose("ZenidSecurity: authorize: \(String(authorize))")
                        if authorize {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            errorMessage()
                        }
                    } else {
                        completion(false)
                        errorMessage()
                    }
                }
        } else {
            completion(false)
            errorMessage()
        }
    }
}
