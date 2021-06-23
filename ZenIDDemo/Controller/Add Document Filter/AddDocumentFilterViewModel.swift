//
//  AddDocumentFilterViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class AddDocumentFilterViewModel {
    
    var role: RecogLib_iOS.DocumentRole?
    var country: RecogLib_iOS.Country?
    var page: RecogLib_iOS.PageCode?
    
    private let saver: DocumentsFilterSaver
    private let coordinator: AddDocumentFilterCoordinable
    
    init(saver: DocumentsFilterSaver, coordinator: AddDocumentFilterCoordinable) {
        self.saver = saver
        self.coordinator = coordinator
    }
    
    func cancel() {
        coordinator.addDocumentDidFinish()
    }
    
    func save() {
        saver.save(document: getDocument()) { [weak self] result in
            self?.handleSaveResult(result: result)
        }
    }
    
    private func getDocument() -> Document {
        .init(
            role: role,
            country: country,
            page: page,
            code: nil
        )
    }
    
    private func handleSaveResult(result: DocumentsFilterSaver.Result) {
        switch result {
        case .success :
            coordinator.addDocumentDidFinish()
        case let .failure(error):
            coordinator.addDocumentDidFail(error: error)
        }
    }
    
}
