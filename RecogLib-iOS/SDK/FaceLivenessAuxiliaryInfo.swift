import Foundation

public enum FaceLivenessCheckType: String, Decodable {
    case angle = "Angle"
    case legacyAngle = "LegacyAngle"
    case smile = "Smile"
}

public enum FaceLivenessAngle: String, Decodable {
    case left = "Left"
    case top = "Up"
    case right = "Right"
    case down = "Down"
}

public struct FaceLivenessAuxiliaryMetadata: Decodable {
    enum CodingKeys: String, CodingKey {
        case type = "checkName"
        case date = "unixEpoch"
        case angle = "parameter"
    }

    public let type: FaceLivenessCheckType
    public let date: Date
    public let angle: FaceLivenessAngle?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(FaceLivenessCheckType.self, forKey: .type)
        angle = try? container.decodeIfPresent(FaceLivenessAngle.self, forKey: .angle)
        let timestampString = try container.decode(String.self, forKey: .date)
        date = Date(timeIntervalSince1970: TimeInterval(Int(timestampString) ?? 0))
    }
}

public struct FaceLivenessAuxiliaryInfo {
    public let images: [Data]
    public let metadata: [FaceLivenessAuxiliaryMetadata]
}
