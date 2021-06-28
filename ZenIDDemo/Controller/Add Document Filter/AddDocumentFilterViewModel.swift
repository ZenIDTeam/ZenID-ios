//
//  AddDocumentFilterViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


enum AddDocumentFilterError: Error {
    case invalidInput
}

final class AddDocumentFilterViewModel {
    
    var role: RecogLib_iOS.DocumentRole?
    var country: RecogLib_iOS.Country?
    var page: RecogLib_iOS.PageCode?
    
    private let saver: DocumentsFilterSaver
    private let validator: DocumentsFilterValidator
    private let coordinator: AddDocumentFilterCoordinable
    
    init(saver: DocumentsFilterSaver, validator: DocumentsFilterValidator, coordinator: AddDocumentFilterCoordinable) {
        self.saver = saver
        self.validator = validator
        self.coordinator = coordinator
    }
    
    func cancel() {
        coordinator.addDocumentDidFinish()
    }
    
    func save()   {
        if validateAndShowErrorIfNecesary() {
            return
        }
        saver.save(document: getDocument()) { [weak self] result in
            self?.handleSaveResult(result: result)
        }
    }
    
    func validate() throws {
        if !validator.validate(input: .init(documents: [getDocument()])) {
            throw AddDocumentFilterError.invalidInput
        }
    }
    
    private func validateAndShowErrorIfNecesary() -> Bool {
        do {
            try validate()
        } catch {
            coordinator.showError(error: NSLocalizedString("document-filter-invalid-input", comment: ""))
            return true
        }
        return false
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
