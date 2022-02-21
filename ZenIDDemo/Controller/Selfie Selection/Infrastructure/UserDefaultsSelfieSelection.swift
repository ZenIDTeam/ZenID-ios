//
//  InMemorySelfieSelection.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 25.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class UserDefaultsSelfieSelection {
    
}

extension UserDefaultsSelfieSelection: SelfieSelectionLoader {
    func load() throws -> FaceMode? {
        Defaults.selectedFaceMode
    }
}

extension UserDefaultsSelfieSelection: SelfieSelectionSaver {
    func save(mode: FaceMode?, completion: (SelfieSelectionSaver.Result) -> Void) {
        Defaults.selectedFaceMode = mode
        completion(.success(()))
    }
}
