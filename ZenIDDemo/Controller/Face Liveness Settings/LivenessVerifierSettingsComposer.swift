//
//  LivenessVerifierSettingsComposer.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import UIKit

final class LivenessVerifierSettingsComposer {
    static func compose(loader: LivenessVerifierSettingsLoader, updater: LivenessVerifierSettingsUpdater) -> LivenessVerifierSettingsViewController {
        let viewController = LivenessVerifierSettingsViewController()
        viewController.viewModel = resolve(loader: loader, updater: updater)
        viewController.viewModel.onUpdate = { [weak viewController] items in
            viewController?.tableView.sections = [
                .init(
                    title: nil,
                    cells: items.map({ map($0) })
                )
            ]
        }
        return viewController
    }

    private static func resolve(loader: LivenessVerifierSettingsLoader, updater: LivenessVerifierSettingsUpdater) -> LivenessVerifierSettingsViewModel {
        .init(loader: loader, updater: updater)
    }

    private static func map(_ type: VerifierSettingsType) -> TableCellController {
        switch type {
        case .interval(let viewModel):
            return SettingsCellController(viewModel: viewModel)
        case .switch(let viewModel):
            return SettingsSwitchCellController(viewModel: viewModel)
        }
    }
}
