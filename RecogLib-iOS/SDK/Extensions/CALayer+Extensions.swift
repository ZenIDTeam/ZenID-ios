//
//  CALayer+Extensions.swift
//  RecogLib-iOS
//
//  Created by Vladimir Belohradsky on 15.02.2024.
//  Copyright © 2024 Marek Stana. All rights reserved.
//

import Foundation

extension CALayer {
    
    /// Set layer frame without animating transition.
    /// 
    /// - Parameter frame: New frame.
    func setFrameWithoutAnimation(_ frame: CGRect) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKeyPath: kCATransactionDisableActions)
        self.frame = frame
        CATransaction.commit()
    }
    
}
