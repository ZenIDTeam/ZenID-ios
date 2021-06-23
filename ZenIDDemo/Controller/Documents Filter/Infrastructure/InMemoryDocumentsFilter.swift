//
//  InMemoryDocumentsFilter.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class InMemoryDocumentsFilter {
    
    private var documents: [Document] = []
    
    init() {
        documents.append(Document(role: .Drv, country: .Sk, page: .Front, code: nil))
        documents.append(Document(role: .Idc, country: .Sk, page: .Front, code: nil))
    }
    
}

extension InMemoryDocumentsFilter: DocumentsFilterLoader {
    func load(completion: (DocumentsFilterLoader.Result) -> Void) {
        completion(.success(documents))
    }
}

extension InMemoryDocumentsFilter: DocumentsFilterDeleter {
    func delete(document: Document, completion: (DocumentsFilterDeleter.Result) -> Void) {
        if let index = documents.firstIndex(of: document) {
            documents.remove(at: index)
        }
        completion(.success(()))
    }
}

extension InMemoryDocumentsFilter: DocumentsFilterSaver {
    func save(document: Document, completion: (DocumentsFilterSaver.Result) -> Void) {
        documents.append(document)
        completion(.success(()))
    }
}
