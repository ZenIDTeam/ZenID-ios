//
//  SelfieSelectionLoader.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 25.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


protocol SelfieSelectionLoader {
    typealias Result = Swift.Result<FaceMode?, Error>
    typealias Completion = (Result) -> Void
    
    func load(completion: Completion)
}

protocol SelfieSelectionSaver {
    typealias Result = Swift.Result<Void, Error>
    typealias Completion = (Result) -> Void
    
    func save(mode: FaceMode?, completion: Completion)
}
