//
//  DocumentVerifierSettings.swift
//  RecogLib-iOS
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import Foundation


public struct DocumentVerifierSettings: Equatable {
    public let specularAcceptableScore: Int
    public let documentBlurAcceptableScore: Int
    public let timeToBlurMaxToleranceInSeconds: Int
    public let showTimer: Bool
    
    public init(specularAcceptableScore: Int = 50, documentBlurAcceptableScore: Int = 50, timeToBlurMaxToleranceInSeconds: Int = 10, showTimer: Bool = false) {
        self.specularAcceptableScore = specularAcceptableScore
        self.documentBlurAcceptableScore = documentBlurAcceptableScore
        self.timeToBlurMaxToleranceInSeconds = timeToBlurMaxToleranceInSeconds
        self.showTimer = showTimer
    }
}
