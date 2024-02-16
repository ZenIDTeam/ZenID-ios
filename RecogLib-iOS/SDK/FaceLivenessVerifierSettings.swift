import Foundation

public struct FaceLivenessVerifierSettings: Equatable {
    
    public let isLegacyModeEnabled: Bool
    
    public let maxAuxiliaryImageSize: Int
    
    public let visualizerVersion: Int

    public init(
        isLegacyModeEnabled: Bool = false,
        maxAuxiliaryImageSize: Int = 300,
        visualizerVersion: Int = 1
    ) {
        self.isLegacyModeEnabled = isLegacyModeEnabled
        self.maxAuxiliaryImageSize = maxAuxiliaryImageSize
        self.visualizerVersion = visualizerVersion
    }
}

