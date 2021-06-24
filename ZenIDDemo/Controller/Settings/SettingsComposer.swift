//
//  SettingsComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SettingsComposer {
    
    static func compose(coordinator: SettingsCoordinable) -> SettingsViewController {
        let viewController = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        viewController.viewModel = resolve(coordinator: coordinator)
        viewController.contentView.tableView.sections = getSections(
            viewController: viewController,
            coordinator: coordinator
        )
        return viewController
    }
    
    private static func resolve(coordinator: SettingsCoordinable) -> SettingsViewModel {
        .init(coordinator: coordinator)
    }
    
    private static func getSections(viewController: UIViewController, coordinator: SettingsCoordinable) -> [TableViewSectionViewModel] {
        [
            .init(
                title: nil,
                cells: [
                    BasicTableCellController(viewModel: .init(title: NSLocalizedString("settings-document-verifier-settings", comment: ""), action: {
                        coordinator.settingsOpenDocumentVerifierSettings()
                    }))
                ]
            ),
            .init(
                title: nil,
                cells: [
                    BasicTableCellController(viewModel: .init(title: NSLocalizedString("settings-filter", comment: ""), action: {
                        coordinator.settingsOpenDocumentsFilter()
                    }))
                ]
            ),
            .init(
                title: nil,
                cells: [
                    ContactTableCellController(),
                    LogoutTableCellController(viewController: viewController)
                ]
            )
        ]
    }
    
}
