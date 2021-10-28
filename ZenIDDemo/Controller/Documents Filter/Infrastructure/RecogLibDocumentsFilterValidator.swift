//
//  RecogLibDocumentsFilterValidator.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 28.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class RecogLibDocumentsFilterValidator: DocumentsFilterValidator {
    
    private let documentVerifier: DocumentVerifier
    
    init() {
        documentVerifier = DocumentVerifier(role: nil, country: nil, page: nil, code: nil, language: .Czech)
        documentVerifier.loadModels(.init(url: URL.modelsDocuments)!)
    }
    
    func validate(input: DocumentsInput) -> Bool {
        documentVerifier.validate(input: input)
    }
}
