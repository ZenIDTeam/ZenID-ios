//
//  SelfieResult.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 23/09/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

public struct SelfieResult {
    public var selfieState: SelfieState
    
    init?(selfieState: Int32) {
        guard let selfieState = SelfieState(rawValue: Int(selfieState)) else {
            return nil
        }
        self.selfieState = selfieState
    }
}
