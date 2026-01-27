//
//  NavigationManager.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 16.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI
import ZenID

class NavigationManager: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func navigate(to screen: Screen) {
        path.append(screen)
    }
    
    func pop(steps: Int = 1) {
        if !path.isEmpty, path.count >= steps {
            path.removeLast(steps)
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum Screen: Hashable {
    case login
    case profile
    case pickCountry
    case pickRole
    case pickPage
    case documentScanner
    case hologramCheck
    case facelivenessCheck
    case selfieCheck
    case msLivenessCheck
    case licencePlateCheck
    case result(InvestigateSamplesResponse)
}
