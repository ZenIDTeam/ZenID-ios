//
//  FaceLivenessAuxiliaryInfo.swift
//  RecogLib-iOS
//
//  Created by Libor on 13.12.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import Foundation

public enum FaceLivenessCheckType: String, Decodable {
    case angle = "Angle"
    case legacyAngle = "LegacyAngle"
    case smile = "Smile"
}

public enum FaceLivenessAngle: String, Decodable {
    case left = "Left"
    case top = "Top"
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
}

public struct FaceLivenessAuxiliaryInfo {
    public let images: [Data]
    public let metadata: [FaceLivenessAuxiliaryMetadata]
}
