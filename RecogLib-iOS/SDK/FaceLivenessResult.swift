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
    public let signature: ImageSignature?
    
    init?(faceLivenessState: Int32, signature: CImageSignature) {
        guard let faceLivenessState = FaceLivenessState(rawValue: Int(faceLivenessState)) else {
            return nil
        }
        self.faceLivenessState = faceLivenessState
        self.signature = DocumentSignatureMapper.map(signature)
    }
}
