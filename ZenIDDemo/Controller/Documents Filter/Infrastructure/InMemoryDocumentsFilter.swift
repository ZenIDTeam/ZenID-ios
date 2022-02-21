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
        documents.append(Document(role: .Pas, country: .Cz, page: .Front, code: nil))
        documents.append(Document(role: .Drv, country: .Sk, page: .Front, code: nil))
    }
    
}

extension InMemoryDocumentsFilter: DocumentsFilterLoader {
    func load() throws -> [Document] {
        documents
    }
}

extension InMemoryDocumentsFilter: DocumentsFilterDeleter {
    func delete(document: Document) {
        if let index = documents.firstIndex(of: document) {
            documents.remove(at: index)
        }
    }
}

extension InMemoryDocumentsFilter: DocumentsFilterSaver {
    func save(document: Document) {
        documents.append(document)
    }
}
