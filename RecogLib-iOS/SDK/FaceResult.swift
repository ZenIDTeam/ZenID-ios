//
//  FaceResult.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 17/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

public struct FaceResult {
    public var faceStage: FaceStage
    
    init?(faceStage: Int32) {
        guard let faceStage = FaceStage(rawValue: Int(faceStage)) else {
            return nil
        }
        self.faceStage = faceStage
    }
}
