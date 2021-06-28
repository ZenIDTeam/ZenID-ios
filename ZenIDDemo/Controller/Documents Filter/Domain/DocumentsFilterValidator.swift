//
//  DocumentsFilterValidater.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 28.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


protocol DocumentsFilterValidator {
    func validate(input: DocumentsInput) -> Bool
}
