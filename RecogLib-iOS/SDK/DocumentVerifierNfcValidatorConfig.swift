import Foundation

public struct DocumentVerifierNfcValidatorSettings {
    
//    timeout not supported on Apple devices
//    public let nfcChipReadingTimeoutSeconds: Int
    
    public let numberOfReadingAttempts: Int
    
    public let skipNfcAllowed: Bool
    
    public let noNfcMeansError: Bool
    
    public let isEnabled: Bool
    
    public let acceptScore: Int
    
    public let scoreStep: Int
    
    public let isTestEnabled: Bool
}
