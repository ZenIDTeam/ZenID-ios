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
        [
            SelectionItemViewModel(title: DocumentRole.Idc.description),
            SelectionItemViewModel(title: DocumentRole.Pas.description),
            SelectionItemViewModel(title: DocumentRole.Drv.description),
            SelectionItemViewModel(title: DocumentRole.Res.description),
            SelectionItemViewModel(title: DocumentRole.Gun.description),
            SelectionItemViewModel(title: DocumentRole.Hic.description)
        ]
    }
    
    private func didSelect(item: SelectionItemViewModel) {
        update(viewModel: getViewModel(item: item))
        if item.title == DocumentRole.Idc.description {
            onSelection(.Idc)
        } else if item.title == DocumentRole.Pas.description {
            onSelection(.Pas)
        } else if item.title == DocumentRole.Drv.description {
            onSelection(.Drv)
        } else if item.title == DocumentRole.Res.description {
            onSelection(.Res)
        } else if item.title == DocumentRole.Gun.description {
            onSelection(.Gun)
        } else if item.title == DocumentRole.Hic.description {
            onSelection(.Hic)
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
