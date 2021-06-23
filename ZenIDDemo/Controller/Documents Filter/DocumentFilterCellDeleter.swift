//
//  DocumentFilterDeleter.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class DocumentFilterCellDeleter {
    
    private let service: DocumentsFilterDeleter
    private let document: Document
    
    init(service: DocumentsFilterDeleter, document: Document) {
        self.service = service
        self.document = document
    }
    
    func execute(completion: @escaping DocumentsFilterDeleter.Completion) {
        service.delete(document: document, completion: completion)
    }
    
}
