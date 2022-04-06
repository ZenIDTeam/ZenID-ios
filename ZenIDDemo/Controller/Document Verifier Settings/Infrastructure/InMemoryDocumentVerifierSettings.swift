//
//  InMemoryDocumentVerifierSettings.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class InMemoryDocumentVerifierSettings {
    
    private var settings: DocumentVerifierSettings = .init()
    
}

extension InMemoryDocumentVerifierSettings: DocumentVerifierSettingsLoader {
    func load() throws -> DocumentVerifierSettings {
        settings
    }
}

extension InMemoryDocumentVerifierSettings: DocumentVerifierSettingsUpdater {
    func update(specularAcceptableScore: Int) {
        settings = settings.update(specularAcceptableScore: specularAcceptableScore)
    }
    
    func update(documentBlurAcceptableScore: Int) {
        settings = settings.update(documentBlurAcceptableScore: documentBlurAcceptableScore)
    }
    
    func update(timeToBlurMaxToleranceInSeconds: Int) {
        settings = settings.update(timeToBlurMaxToleranceInSeconds: timeToBlurMaxToleranceInSeconds)
    }
    
    func update(showTimer: Bool) {
        settings = settings.update(showTimer: showTimer)
    }
    
    func update(showAimingCircle: Bool) {
        settings = settings.update(showAimingCircle: showAimingCircle)
    }
    
    func update(drawOutline: Bool) {
        settings = settings.update(drawOutline: drawOutline)
    }
}

private extension DocumentVerifierSettings {
    func update(specularAcceptableScore: Int? = nil, documentBlurAcceptableScore: Int? = nil, timeToBlurMaxToleranceInSeconds: Int? = nil, showTimer: Bool? = nil, showAimingCircle: Bool? = nil, drawOutline: Bool? = nil) -> DocumentVerifierSettings {
        .init(
            specularAcceptableScore: specularAcceptableScore ?? self.specularAcceptableScore,
            documentBlurAcceptableScore: documentBlurAcceptableScore ?? self.documentBlurAcceptableScore,
            timeToBlurMaxToleranceInSeconds: timeToBlurMaxToleranceInSeconds ?? self.timeToBlurMaxToleranceInSeconds,
            showTimer: showTimer ?? self.showTimer,
            showAimingCircle: showAimingCircle ?? self.showAimingCircle,
            drawOutline: drawOutline ?? self.drawOutline
        )
    }
}
