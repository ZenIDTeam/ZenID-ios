//
//  SettingsComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SettingsComposer {
    
    static func compose(selfieSelectionLoader: SelfieSelectionLoader, configService: ConfigService, coordinator: SettingsCoordinable) -> SettingsViewController {
        let viewController = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        viewController.viewModel = resolve(coordinator: coordinator)
        viewController.viewModel.onChange = { [unowned viewController] in
            let faceMode = try? selfieSelectionLoader.load()
            viewController.contentView.tableView.sections = getSections(viewController: viewController, configService: configService, coordinator: coordinator, faceMode: faceMode)
        }
        return viewController
    }
    
    private static func resolve(coordinator: SettingsCoordinable) -> SettingsViewModel {
        .init(coordinator: coordinator)
    }
    
    private static func getSections(viewController: UIViewController, configService: ConfigService, coordinator: SettingsCoordinable, faceMode: FaceMode?) -> [TableViewSectionViewModel] {
        [
            .init(
                title: nil,
                cells: [
                    SelfieTableCellController(viewModel: .init(name: faceMode?.rawValue.uppercased(), action: {
                        coordinator.settingsOpenSelfieSelection()
                    })),
                    DataTypeTableViewCellController(service: configService),
                    NfcTableViewCellController(service: configService)
                ]
            ),
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
                    BasicTableCellController(viewModel: .init(title: NSLocalizedString("settings-faceliveness-verifier-settings", comment: ""), action: {
                        coordinator.settingsOpenFaceLivenessVerifierSettings()
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
                    DebugTableViewCellController(service: configService)
                ]
            ),
            .init(
                title: nil,
                cells: [
                    ContactTableCellController(),
                    LogoutTableCellController(
                        viewController: viewController,
                        coordinator: coordinator
                    )
                ]
            )
        ]
    }
    
}
