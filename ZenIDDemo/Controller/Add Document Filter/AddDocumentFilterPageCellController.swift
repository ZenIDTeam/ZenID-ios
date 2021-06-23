//
//  AddDocumentFilterPageCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class AddDocumentFilterPageCellController: BasicTableCellController {
    
    private let onSelection: (RecogLib_iOS.PageCode) -> Void
    private let coordinator: AddDocumentFilterCoordinable
    
    init(onSelection: @escaping (RecogLib_iOS.PageCode) -> Void, coordinator: AddDocumentFilterCoordinable) {
        self.onSelection = onSelection
        self.coordinator = coordinator
        super.init(viewModel: .init(title: "", action: nil))
        update(viewModel: getViewModel(item: nil))
    }
    
    override func select() {
        coordinator.addDocumentFilterOpenSelection(
            title: NSLocalizedString("document-page", comment: ""),
            items: getSelectionOptions()) { [weak self] selectedItem in
            self?.didSelect(item: selectedItem)
        }
    }
    
    private func getSelectionOptions() -> [SelectionItemViewModel] {
        [
            SelectionItemViewModel(title: RecogLib_iOS.PageCode.Front.description),
            SelectionItemViewModel(title: RecogLib_iOS.PageCode.Back.description)
        ]
    }
    
    private func didSelect(item: SelectionItemViewModel) {
        update(viewModel: getViewModel(item: item))
        if item.title == RecogLib_iOS.PageCode.Front.description {
            onSelection(.Front)
        } else if item.title == RecogLib_iOS.PageCode.Back.description {
            onSelection(.Back)
        }
    }
    
    private func getViewModel(item: SelectionItemViewModel?) -> BasicTableCellViewModel {
        .init(
            title: NSLocalizedString("document-page", comment: ""),
            detail: item?.title,
            action: {}
        )
    }
    
}
