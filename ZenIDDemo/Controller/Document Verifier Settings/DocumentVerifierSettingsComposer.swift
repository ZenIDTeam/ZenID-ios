//
//  DocumentVerifierSettingsComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentVerifierSettingsComposer {
    
    static func compose(loader: DocumentVerifierSettingsLoader, updater: DocumentVerifierSettingsUpdater) -> DocumentVerifierSettingsViewController {
        let viewController = DocumentVerifierSettingsViewController()
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
    
    private static func resolve(loader: DocumentVerifierSettingsLoader, updater: DocumentVerifierSettingsUpdater) -> DocumentVerifierSettingsViewModel {
        .init(loader: loader, updater: updater)
    }
    
    private static func map(_ type: DocumentVerifierSettingsType) -> TableCellController {
        switch type {
        case .interval(let viewModel):
            return SettingsCellController(viewModel: viewModel)
        case .switch(let viewModel):
            return SettingsSwitchCellController(viewModel: viewModel)
        }
    }
    
}

