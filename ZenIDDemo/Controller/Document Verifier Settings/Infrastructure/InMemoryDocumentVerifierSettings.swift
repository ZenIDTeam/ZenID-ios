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
    func load(completion: (DocumentVerifierSettingsLoader.Result) -> Void) {
        completion(.success(settings))
    }
}

extension InMemoryDocumentVerifierSettings: DocumentVerifierSettingsUpdater {
    func update(specularAcceptableScore: Int, completion: (DocumentVerifierSettingsUpdater.Result) -> Void) {
        settings = settings.update(specularAcceptableScore: specularAcceptableScore)
    }
    
    func update(documentBlurAcceptableScore: Int, completion: (DocumentVerifierSettingsUpdater.Result) -> Void) {
        settings = settings.update(documentBlurAcceptableScore: documentBlurAcceptableScore)
    }
    
    func update(timeToBlurMaxToleranceInSeconds: Int, completion: (DocumentVerifierSettingsUpdater.Result) -> Void) {
        settings = settings.update(timeToBlurMaxToleranceInSeconds: timeToBlurMaxToleranceInSeconds)
    }
}

private extension DocumentVerifierSettings {
    func update(specularAcceptableScore: Int? = nil, documentBlurAcceptableScore: Int? = nil, timeToBlurMaxToleranceInSeconds: Int? = nil) -> DocumentVerifierSettings {
        .init(
            specularAcceptableScore: specularAcceptableScore ?? self.specularAcceptableScore,
            documentBlurAcceptableScore: documentBlurAcceptableScore ?? self.documentBlurAcceptableScore,
            timeToBlurMaxToleranceInSeconds: timeToBlurMaxToleranceInSeconds ?? self.timeToBlurMaxToleranceInSeconds
        )
    }
}
