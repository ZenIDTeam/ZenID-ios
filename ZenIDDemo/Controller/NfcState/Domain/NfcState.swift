//
//  NfcEnabledLoader.swift
//  ZenIDDemo
//
//  Created by Lukas Gergel on 09.04.2023.
//  Copyright © 2023 Trask, a.s. All rights reserved.
//

import Foundation

typealias NfcStateProvider = NfcStateLoader & NfcStateSaver

protocol NfcStateLoader {
    func load() throws -> Bool
}

protocol NfcStateSaver {
    typealias Result = Swift.Result<Void, Error>
    typealias Completion = (Result) -> Void
    
    func save(isEnabled: Bool, completion: Completion)
}
