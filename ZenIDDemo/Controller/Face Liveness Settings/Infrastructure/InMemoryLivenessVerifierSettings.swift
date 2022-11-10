//
//  InMemoryLivenessVerifierSettings.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

final class InMemoryLivenessVerifierSettings {
    private var settings: FaceLivenessVerifierSettings = .init()
}

extension InMemoryLivenessVerifierSettings: LivenessVerifierSettingsLoader {
    func load() throws -> FaceLivenessVerifierSettings {
        settings
    }
}

extension InMemoryLivenessVerifierSettings: LivenessVerifierSettingsUpdater {
    func update(isLegacyModeEnabled: Bool) {
        settings = settings.update(isLegacyModeEnabled: isLegacyModeEnabled)
    }

    func update(maxAuxiliaryImageSize: Int) {
        settings = settings.update(maxAuxiliaryImageSize: maxAuxiliaryImageSize)
    }
}

private extension FaceLivenessVerifierSettings {
    func update(isLegacyModeEnabled: Bool? = nil, maxAuxiliaryImageSize: Int? = nil, visualizerVersion: Int? = nil) -> FaceLivenessVerifierSettings {
        .init(
            isLegacyModeEnabled: isLegacyModeEnabled ?? self.isLegacyModeEnabled,
            maxAuxiliaryImageSize: maxAuxiliaryImageSize ?? self.maxAuxiliaryImageSize,
            visualizerVersion: visualizerVersion ?? self.visualizerVersion
        )
    }
}
