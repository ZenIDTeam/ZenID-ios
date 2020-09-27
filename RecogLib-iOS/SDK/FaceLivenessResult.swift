//
//  FaceLivenessResult.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 17/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

public struct FaceLivenessResult {
    public var faceLivenessStage: FaceLivenessStage
    
    init?(faceLivenessStage: Int32) {
        guard let faceLivenessStage = FaceLivenessStage(rawValue: Int(faceLivenessStage)) else {
            return nil
        }
        self.faceLivenessStage = faceLivenessStage
    }
}
