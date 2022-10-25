public struct FaceLivenessStepParameters: Decodable {
    public let faceCenterX: Double
    public let faceCenterY: Double
    public let faceHeight: Double
    public let faceWidth: Double
    public let hasFailed: Bool
    public let headPitch: Double
    public let headRoll: Double
    public let headYaw: Double
    public let name: String
    public let passedCheckCount: Int
    public let totalCheckCount: Int
}
