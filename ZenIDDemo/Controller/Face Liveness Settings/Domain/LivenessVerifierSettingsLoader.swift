//
//  LivenessVerifierSettingsLoader.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

protocol LivenessVerifierSettingsLoader {
    func load() throws -> FaceLivenessVerifierSettings
}

protocol LivenessVerifierSettingsUpdater {
    func update(isLegacyModeEnabled: Bool)
    func update(maxAuxiliaryImageSize: Int)
}
