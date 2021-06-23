//
//  DocumentsFilterComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentsFilterComposer {
    
    static func compose(loader: DocumentsFilterLoader, deleter: DocumentsFilterDeleter, saver: DocumentsFilterSaver, coordinator: DocumentsFilterCoordinable) -> DocumentsFilterViewController {
        let viewController = UIStoryboard(name: "DocumentsFilter", bundle: nil).instantiateViewController(withIdentifier: "DocumentsFilterViewController") as! DocumentsFilterViewController
        viewController.viewModel = resolve(loader: loader, coordinator: coordinator)
        viewController.viewModel.onChange = DocumentsFilterViewModelAdapter(
            tableView: viewController.contentView.tableView,
            deleter: deleter
        ).map
        return viewController
    }
    
    private static func resolve(loader: DocumentsFilterLoader, coordinator: DocumentsFilterCoordinable) -> DocumentsFilterViewModel {
        .init(loader: loader, coordinator: coordinator)
    }
    
}
