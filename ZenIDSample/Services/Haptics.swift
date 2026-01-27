//
//  Haptics.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import UIKit

@MainActor class Haptics {
    
    static var shared: Haptics = {
        Haptics()
    }()
    
    private var haptic = UINotificationFeedbackGenerator()
    
    func playSuccess() {
        haptic.notificationOccurred(.success)
    }
    
    func playError() {
        haptic.notificationOccurred(.error)
    }
    
}
