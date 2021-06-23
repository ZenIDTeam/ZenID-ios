//
//  AddDocumentFilterComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class AddDocumentFilterComposer {
    
    static func compose(saver: DocumentsFilterSaver, coordinator: AddDocumentFilterCoordinable) -> AddDocumentFilterViewController {
        let viewController = UIStoryboard(name: "AddDocumentFilter", bundle: nil).instantiateViewController(withIdentifier: "AddDocumentFilterViewController") as! AddDocumentFilterViewController
        viewController.viewModel = resolve(saver: saver, coordinator: coordinator)
        viewController.contentView.tableView.sections = [
            .init(title: nil, cells: [
                AddDocumentFilterRoleCellController(
                    onSelection: { [weak viewController] role in
                        viewController?.viewModel.role = role
                    },
                    coordinator: coordinator
                ),
                AddDocumentFilterCountryCellController(
                    onSelection: { [weak viewController] country in
                        viewController?.viewModel.country = country
                    },
                    coordinator: coordinator
                ),
                AddDocumentFilterPageCellController(
                    onSelection: { [weak viewController] page in
                        viewController?.viewModel.page = page
                    },
                    coordinator: coordinator
                )
            ])
        ]
        return viewController
    }
    
    private static func resolve(saver: DocumentsFilterSaver, coordinator: AddDocumentFilterCoordinable) -> AddDocumentFilterViewModel {
        .init(saver: saver, coordinator: coordinator)
    }
    
}
