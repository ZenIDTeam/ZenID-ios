//
//  SettingsCoordinable.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


protocol SettingsCoordinable {
    func settingsDidFinish()
    func settingsOpenSelfieSelection()
    func settingsOpenDocumentsFilter()
    func settingsOpenDocumentVerifierSettings()
    func settingsOpenFaceLivenessVerifierSettings()
    func settingsDidLogout()
}
