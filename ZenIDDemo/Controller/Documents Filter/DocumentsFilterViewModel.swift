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
        do {
            let documents = try loader.load()
            refresh(documents: documents)
        } catch {
            refresh(documents: [])
        }
    }
    
    func addNewFilter() {
        coordinator.documentsFilterAddNewDocumentFilter()
    }
    
    private func refresh(documents: [Document]) {
        onChange?(documents)
    }
    
}
