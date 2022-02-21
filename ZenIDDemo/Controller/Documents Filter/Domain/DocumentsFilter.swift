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
    func load() throws -> [Document]
}

protocol DocumentsFilterDeleter {
    func delete(document: Document) throws
}

protocol DocumentsFilterSaver {
    func save(document: Document) throws
}
