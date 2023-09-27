//
//  DocumentVerifierSettingsViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

enum DocumentVerifierSettingsType {
    case interval(SettingsValueViewModel)
    case `switch`(SettingsSwitchViewModel)
}

final class DocumentVerifierSettingsViewModel {
    var onUpdate: (([DocumentVerifierSettingsType]) -> Void)?

    private let loader: DocumentVerifierSettingsLoader
    private let updater: DocumentVerifierSettingsUpdater

    init(loader: DocumentVerifierSettingsLoader, updater: DocumentVerifierSettingsUpdater) {
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

    private func update(settings: DocumentVerifierSettings) {
        let intervalItems: [SettingsValueViewModel] = [
            .init(
                title: NSLocalizedString("document-verifier-settings-blur-tolerance", comment: ""),
                value: Float(settings.timeToBlurMaxToleranceInSeconds), min: 0.0, max: 100.0,
                onChange: { [weak self] value in
                    self?.updater.update(timeToBlurMaxToleranceInSeconds: Int(value))
                }
            ),
        ]
        let switchItems: [SettingsSwitchViewModel] = [
            .init(
                title: NSLocalizedString("document-verifier-settings-timer", comment: ""),
                value: settings.showTimer,
                onChange: { [weak self] value in
                    self?.updater.update(showTimer: value)
                }
            ),
            .init(
                title: NSLocalizedString("document-verifier-settings-circle", comment: ""),
                value: settings.showAimingCircle,
                onChange: { [weak self] value in
                    self?.updater.update(showAimingCircle: value)
                }
            ),
            .init(
                title: NSLocalizedString("document-verifier-settings-outline", comment: ""),
                value: settings.drawOutline,
                onChange: { [weak self] value in
                    self?.updater.update(drawOutline: value)
                }
            )
        ]

        onUpdate?(intervalItems.map({ .interval($0) }) + switchItems.map({ .switch($0) }))
    }
}
