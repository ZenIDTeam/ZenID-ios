//
//  DocumentsFilterViewModelAdapter.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class DocumentsFilterViewModelAdapter {
    
    private let tableView: GroupedTableView
    private let deleter: DocumentsFilterDeleter
    private let onDelete: () -> Void
    
    init(tableView: GroupedTableView, deleter: DocumentsFilterDeleter, onDelete: @escaping () -> Void) {
        self.tableView = tableView
        self.deleter = deleter
        self.onDelete = onDelete
    }
    
    func map(documents: [Document]) {
        tableView.sections = [.init(title: nil, cells: documents.map { document in
            DocumentFilterCellController(
                viewModel: map(document),
                deleter: DocumentFilterCellDeleter(
                    service: deleter,
                    document: document
                ),
                onDelete: onDelete
            )
        })]
    }
    
    private func map(_ document: Document) -> DocumentViewModel {
        .init(
            role: document.role?.description,
            country: document.country?.description,
            page: document.page?.description
        )
    }
    
}
