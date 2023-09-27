import Foundation

public struct DocumentVerifierSettings: Equatable {
    public let timeToBlurMaxToleranceInSeconds: Int
    public let showTimer: Bool
    public let showAimingCircle: Bool
    public let drawOutline: Bool
    public let visualizerVersion: Int

    public init(timeToBlurMaxToleranceInSeconds: Int = 10, showTimer: Bool = false, showAimingCircle: Bool = false, drawOutline: Bool = true, visualizerVersion: Int = 1
) {
        self.timeToBlurMaxToleranceInSeconds = timeToBlurMaxToleranceInSeconds
        self.showTimer = showTimer
        self.showAimingCircle = showAimingCircle
        self.drawOutline = drawOutline
        self.visualizerVersion = visualizerVersion
    }
}
