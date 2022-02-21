//
//  SelfieSelectionLoader.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 25.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


protocol SelfieSelectionLoader {
    func load() throws -> FaceMode?
}

protocol SelfieSelectionSaver {
    typealias Result = Swift.Result<Void, Error>
    typealias Completion = (Result) -> Void
    
    func save(mode: FaceMode?, completion: Completion)
}
