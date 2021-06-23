//
//  DocumentsFilterViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class DocumentsFilterViewModel {
    
    var onChange: (([Document]) -> Void)?
    
    private let loader: DocumentsFilterLoader
    private let coordinator: DocumentsFilterCoordinable
    
    init(loader: DocumentsFilterLoader, coordinator: DocumentsFilterCoordinable) {
        self.loader = loader
        self.coordinator = coordinator
    }
    
    func reloadData() {
        loader.load { [weak self] result in
            self?.handleLoadResult(result: result)
        }
    }
    
    func addNewFilter() {
        coordinator.documentsFilterAddNewDocumentFilter()
    }
    
    private func handleLoadResult(result: DocumentsFilterLoader.Result) {
        switch result {
        case let .success(documents):
            refresh(documents: documents)
        case .failure:
            refresh(documents: [])
        }
    }
    
    private func refresh(documents: [Document]) {
        onChange?(documents)
    }
    
}
