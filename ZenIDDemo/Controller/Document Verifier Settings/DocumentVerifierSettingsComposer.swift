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
        let viewController = UIStoryboard(name: "DocumentVerifierSettings", bundle: nil).instantiateViewController(withIdentifier: "DocumentVerifierSettingsViewController") as! DocumentVerifierSettingsViewController
        viewController.viewModel = resolve(loader: loader, updater: updater)
        viewController.viewModel.onUpdate = { [weak viewController] items in
            viewController?.contentView.tableView.sections = [
                .init(
                    title: nil,
                    cells: items.map({ viewModel in
                        DocumentVerifierSettingsCellController(viewModel: viewModel)
                    })
                )
            ]
        }
        return viewController
    }
    
    private static func resolve(loader: DocumentVerifierSettingsLoader, updater: DocumentVerifierSettingsUpdater) -> DocumentVerifierSettingsViewModel {
        .init(loader: loader, updater: updater)
    }
    
}

