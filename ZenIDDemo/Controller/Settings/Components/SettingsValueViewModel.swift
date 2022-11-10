//
//  SettingsValueViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


struct SettingsValueViewModel {
    let title: String
    let value: Float
    let min: Float
    let max: Float
    let onChange: (Float) -> Void
}
