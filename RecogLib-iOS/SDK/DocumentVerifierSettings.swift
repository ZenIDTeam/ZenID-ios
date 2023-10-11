import Foundation

public struct DocumentVerifierSettings: Equatable {
    public let showTimer: Bool
    public let showAimingCircle: Bool
    public let drawOutline: Bool
    public let visualizerVersion: Int

    public init(showTimer: Bool = false, showAimingCircle: Bool = false, drawOutline: Bool = true, visualizerVersion: Int = 1
) {
        self.showTimer = showTimer
        self.showAimingCircle = showAimingCircle
        self.drawOutline = drawOutline
        self.visualizerVersion = visualizerVersion
    }
}
