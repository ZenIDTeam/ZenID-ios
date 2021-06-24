//
//  DocumentsFilterSettingsLoader.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


protocol DocumentVerifierSettingsLoader {
    typealias Result = Swift.Result<DocumentVerifierSettings, Error>
    typealias Completion = (Result) -> Void
    
    func load(completion: Completion)
}

protocol DocumentVerifierSettingsUpdater {
    typealias Result = Swift.Result<Void, Error>
    typealias Completion = (Result) -> Void
    
    func update(specularAcceptableScore: Int, completion: Completion)
    func update(documentBlurAcceptableScore: Int, completion: Completion)
    func update(timeToBlurMaxToleranceInSeconds: Int, completion: Completion)
}
