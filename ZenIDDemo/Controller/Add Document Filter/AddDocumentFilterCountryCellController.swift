//
//  AddDocumentFilterRoleCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class AddDocumentFilterCountryCellController: BasicTableCellController {
    
    private let onSelection: (RecogLib_iOS.Country) -> Void
    private let coordinator: AddDocumentFilterCoordinable
    
    init(onSelection: @escaping (RecogLib_iOS.Country) -> Void, coordinator: AddDocumentFilterCoordinable) {
        self.onSelection = onSelection
        self.coordinator = coordinator
        super.init(viewModel: .init(title: "", action: nil))
        update(viewModel: getViewModel(item: nil))
    }
    
    override func select() {
        coordinator.addDocumentFilterOpenSelection(
            title: NSLocalizedString("document-country", comment: ""),
            items: getSelectionOptions()) { [weak self] selectedItem in
            self?.didSelect(item: selectedItem)
        }
    }
    
    private func getSelectionOptions() -> [SelectionItemViewModel] {
        [
            SelectionItemViewModel(title: RecogLib_iOS.Country.Cz.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.Sk.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.At.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.Hu.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.Pl.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.De.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.Hr.description),
            SelectionItemViewModel(title: RecogLib_iOS.Country.It.description)
        ]
    }
    
    private func didSelect(item: SelectionItemViewModel) {
        update(viewModel: getViewModel(item: item))
        if item.title == RecogLib_iOS.Country.Cz.description {
            onSelection(.Cz)
        } else if item.title == RecogLib_iOS.Country.Sk.description {
            onSelection(.Sk)
        } else if item.title == RecogLib_iOS.Country.At.description {
            onSelection(.At)
        } else if item.title == RecogLib_iOS.Country.Hu.description {
            onSelection(.Hu)
        } else if item.title == RecogLib_iOS.Country.Pl.description {
            onSelection(.Pl)
        } else if item.title == RecogLib_iOS.Country.De.description {
            onSelection(.De)
        } else if item.title == RecogLib_iOS.Country.Hr.description {
            onSelection(.Hr)
        } else if item.title == RecogLib_iOS.Country.It.description {
            onSelection(.It)
        }
    }
    
    private func getViewModel(item: SelectionItemViewModel?) -> BasicTableCellViewModel {
        .init(
            title: NSLocalizedString("document-country", comment: ""),
            detail: item?.title,
            action: {}
        )
    }
    
}
