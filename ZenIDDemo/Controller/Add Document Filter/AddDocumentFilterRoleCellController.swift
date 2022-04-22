//
//  AddDocumentFilterRoleCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class AddDocumentFilterRoleCellController: BasicTableCellController {
    
    private let onSelection: (DocumentRole) -> Void
    private let coordinator: AddDocumentFilterCoordinable
    
    init(onSelection: @escaping (DocumentRole) -> Void, coordinator: AddDocumentFilterCoordinable) {
        self.onSelection = onSelection
        self.coordinator = coordinator
        super.init(viewModel: .init(title: "", action: nil))
        update(viewModel: getViewModel(item: nil))
    }
    
    override func select() {
        coordinator.addDocumentFilterOpenSelection(
            title: NSLocalizedString("document-role", comment: ""),
            items: getSelectionOptions()) { [weak self] selectedItem in
            self?.didSelect(item: selectedItem)
        }
    }
    
    private func getSelectionOptions() -> [SelectionItemViewModel] {
        DocumentRole.allCases.map({ SelectionItemViewModel(title: $0.description) })
    }
    
    private func didSelect(item: SelectionItemViewModel) {
        update(viewModel: getViewModel(item: item))
        for role in DocumentRole.allCases {
            if item.title == role.description {
                onSelection(role)
                return
            }
        }
    }
    
    private func getViewModel(item: SelectionItemViewModel?) -> BasicTableCellViewModel {
        .init(
            title: NSLocalizedString("document-role", comment: ""),
            detail: item?.title,
            action: {}
        )
    }
    
}
