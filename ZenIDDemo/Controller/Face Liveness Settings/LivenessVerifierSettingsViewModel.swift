//
//  LivenessVerifierSettingsViewModel.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

enum VerifierSettingsType {
    case interval(SettingsValueViewModel)
    case `switch`(SettingsSwitchViewModel)
}

final class LivenessVerifierSettingsViewModel {
    var onUpdate: (([VerifierSettingsType]) -> Void)?

    private let loader: LivenessVerifierSettingsLoader
    private let updater: LivenessVerifierSettingsUpdater

    init(loader: LivenessVerifierSettingsLoader, updater: LivenessVerifierSettingsUpdater) {
        self.loader = loader
        self.updater = updater
    }

    func reloadData() {
        do {
            let settings = try loader.load()
            update(settings: settings)
        } catch {
            debugPrint(error)
        }
    }

    private func update(settings: FaceLivenessVerifierSettings) {
        let switchItems: [SettingsSwitchViewModel] = [
            .init(
                title: NSLocalizedString("liveness-verifier-settings-legacy-mode", comment: ""),
                value: settings.isLegacyModeEnabled,
                onChange: { [weak self] value in
                    self?.updater.update(isLegacyModeEnabled: value)
                }
            )
        ]

        let valueItems: [SettingsValueViewModel] = [
            .init(
                title: NSLocalizedString("liveness-verifier-settings-max-image-size", comment: ""),
                value: Float(settings.maxAuxiliaryImageSize), min: 0.0, max: 300.0,
                onChange: { [weak self] value in
                    self?.updater.update(maxAuxiliaryImageSize: Int(value))
                }
            )
        ]
        onUpdate?(valueItems.map({ .interval($0) }) + switchItems.map({ .switch($0) }))
    }
}
