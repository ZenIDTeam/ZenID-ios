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
    func load() throws -> DocumentVerifierSettings
}

protocol DocumentVerifierSettingsUpdater {
    func update(specularAcceptableScore: Int)
    func update(documentBlurAcceptableScore: Int)
    func update(timeToBlurMaxToleranceInSeconds: Int)
    func update(showTimer: Bool)
    func update(showAimingCircle: Bool)
    func update(drawOutline: Bool)
    func update(readBarcode: Bool)
}
