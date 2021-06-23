//
//  DocumentsFilter.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


protocol DocumentsFilterLoader {
    typealias Result = Swift.Result<[Document], Error>
    typealias Completion = (Result) -> Void
    
    func load(completion: Completion)
}

protocol DocumentsFilterDeleter {
    typealias Result = Swift.Result<Void, Error>
    typealias Completion = (Result) -> Void
    
    func delete(document: Document, completion: Completion)
}

protocol DocumentsFilterSaver {
    typealias Result = Swift.Result<Void, Error>
    typealias Completion = (Result) -> Void
    
    func save(document: Document, completion: Completion)
}
