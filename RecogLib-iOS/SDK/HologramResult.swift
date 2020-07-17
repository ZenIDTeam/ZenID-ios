//
//  HologramResult.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 04/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation

public struct HologramResult {
    public var hologramState: HologramState
    
    init?(document: CDocumentInfo) {
        guard let hologramState = HologramState(rawValue: Int(document.hologramState)) else {
            return nil
        }
        self.hologramState = hologramState
    }
}
