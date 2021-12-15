//
//  DocumentsFilterValidatorComposer.swift
//  ZenIDDemo
//
//  Created by Libor on 15.12.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class DocumentsFilterValidatorComposer {
    private static var validator: DocumentsFilterValidator?
    
    static func compose() -> DocumentsFilterValidator {
        if validator == nil {
            validator = RecogLibDocumentsFilterValidator()
        }
        return validator!
    }
}
