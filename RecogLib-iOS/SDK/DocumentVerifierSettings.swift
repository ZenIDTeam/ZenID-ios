//
//  DocumentVerifierSettings.swift
//  RecogLib-iOS
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import Foundation


public struct DocumentVerifierSettings {
    let specularAcceptableScore: Int
    let documentBlurAcceptableScore: Int
    let timeToBlurMaxToleranceInSeconds: Int
}
