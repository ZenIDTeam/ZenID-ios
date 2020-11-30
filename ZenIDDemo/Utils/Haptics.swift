//
//  Haptics.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 11/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import UIKit

final class Haptics {
    public static let shared = Haptics()
    
    private let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    private init() {
        selectionFeedbackGenerator.prepare()
        notificationFeedbackGenerator.prepare()
    }
    
    public func select() {
        selectionFeedbackGenerator.selectionChanged()
    }
    
    public func success() {
        notificationFeedbackGenerator.notificationOccurred(.success)
    }
}

