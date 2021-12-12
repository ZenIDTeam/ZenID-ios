//
//  FaceLivenessVerifierSettings.swift
//  RecogLib-iOS
//
//  Created by Libor on 12.12.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import Foundation


public struct FaceLivenessVerifierSettings: Equatable {
    public let isLegacyModeEnabled: Bool
    public let maxAuxiliaryImageSize: Int
    
    public init(isLegacyModeEnabled: Bool = false, maxAuxiliaryImageSize: Int = 300) {
        self.isLegacyModeEnabled = isLegacyModeEnabled
        self.maxAuxiliaryImageSize = maxAuxiliaryImageSize
    }
}

