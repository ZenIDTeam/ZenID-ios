//
//  SettingsViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class SettingsViewModel {
    
    var onChange: (() -> Void)?
    
    private let coordinator: SettingsCoordinable
    
    init(coordinator: SettingsCoordinable) {
        self.coordinator = coordinator
    }
    
    func finish() {
        coordinator.settingsDidFinish()
    }
    
    func reloadData() {
        onChange?()
    }
    
}
