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
        RecogLib_iOS.Country.allCases.map({ SelectionItemViewModel(title: $0.description) })
    }
    
    private func didSelect(item: SelectionItemViewModel) {
        update(viewModel: getViewModel(item: item))
        for country in RecogLib_iOS.Country.allCases {
            if item.title == country.description {
                onSelection(country)
                return
            }
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
