import Foundation

public struct FaceLivenessVerifierSettings: Equatable {
    public let isLegacyModeEnabled: Bool
    public let maxAuxiliaryImageSize: Int
    
    public init(isLegacyModeEnabled: Bool = false, maxAuxiliaryImageSize: Int = 300) {
        self.isLegacyModeEnabled = isLegacyModeEnabled
        self.maxAuxiliaryImageSize = maxAuxiliaryImageSize
    }
}

