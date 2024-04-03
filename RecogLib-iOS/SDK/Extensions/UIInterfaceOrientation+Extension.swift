//
//  UIInterfaceOrientation+Extension.swift
//  RecogLib-iOS
//
//  Created by Vladimir Belohradsky on 15.02.2024.
//  Copyright © 2024 Marek Stana. All rights reserved.
//

import UIKit

extension UIInterfaceOrientation {
        
    /// Get current user interface orientation.
    public static var current: UIInterfaceOrientation { if #available(iOS 15.0, *) {
            UIApplication
                .shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last?.windowScene?.interfaceOrientation ?? .portrait
        } else if #available(iOS 13.0, *) {
            UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .last { $0.isKeyWindow }?
                .windowScene?.interfaceOrientation ?? .portrait
        } else {
            switch UIDevice.current.orientation {
            case .portrait: .portrait
            case .unknown: .portrait
            case .portraitUpsideDown: .portraitUpsideDown
            case .landscapeLeft: .landscapeLeft
            case .landscapeRight: .landscapeRight
            case .faceUp: .portrait
            case .faceDown: .portraitUpsideDown
            @unknown default: .portrait
            }
        }
    }
}
