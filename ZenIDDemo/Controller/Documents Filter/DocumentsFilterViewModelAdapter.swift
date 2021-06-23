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
    
    init(tableView: GroupedTableView, deleter: DocumentsFilterDeleter) {
        self.tableView = tableView
        self.deleter = deleter
    }
    
    func map(documents: [Document]) {
        tableView.sections = [.init(title: nil, cells: documents.map { document in
            DocumentFilterCellController(
                viewModel: map(document),
                deleter: deleter
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
