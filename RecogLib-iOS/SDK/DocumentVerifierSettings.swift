import Foundation

public struct DocumentVerifierSettings: Equatable {
    public let specularAcceptableScore: Int
    public let documentBlurAcceptableScore: Int
    public let timeToBlurMaxToleranceInSeconds: Int
    public let showTimer: Bool
    public let showAimingCircle: Bool
    public let drawOutline: Bool
    public let readBarcode: Bool
    
    public init(specularAcceptableScore: Int = 50, documentBlurAcceptableScore: Int = 50, timeToBlurMaxToleranceInSeconds: Int = 10, showTimer: Bool = false, showAimingCircle: Bool = false, drawOutline: Bool = false, readBarcode: Bool = true) {
        self.specularAcceptableScore = specularAcceptableScore
        self.documentBlurAcceptableScore = documentBlurAcceptableScore
        self.timeToBlurMaxToleranceInSeconds = timeToBlurMaxToleranceInSeconds
        self.showTimer = showTimer
        self.showAimingCircle = showAimingCircle
        self.drawOutline = drawOutline
        self.readBarcode = readBarcode
    }
}
