//
//  FaceLivenessResult.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 17/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

public struct FaceLivenessResult {
    public var faceLivenessState: FaceLivenessState
    
    init?(faceLivenessState: Int32) {
        guard let faceLivenessState = FaceLivenessState(rawValue: Int(faceLivenessState)) else {
            return nil
        }
        self.faceLivenessState = faceLivenessState
    }
}
