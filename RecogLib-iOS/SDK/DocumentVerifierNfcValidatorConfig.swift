import Foundation

public struct DocumentVerifierNfcValidatorConfig {
    public let nfcChipReadingTimeoutSeconds: Int
    public let numberOfReadingAttempts: Int
    public let skipNfcAllowed: Bool
    public let noNfcMeansError: Bool
    public let isEnabled: Bool
    public let acceptScore: Int
    public let scoreStep: Int
    public let isTestEnabled: Bool
}
