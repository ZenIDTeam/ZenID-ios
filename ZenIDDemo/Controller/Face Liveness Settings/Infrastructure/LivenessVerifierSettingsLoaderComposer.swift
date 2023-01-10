//
//  LivenessVerifierSettingsLoaderComposer.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import Foundation


final class LivenessVerifierSettingsLoaderComposer {
    
    private static var service: (LivenessVerifierSettingsLoader & LivenessVerifierSettingsUpdater)?
    
    static func compose() -> LivenessVerifierSettingsLoader & LivenessVerifierSettingsUpdater {
        if service == nil {
            service = InMemoryLivenessVerifierSettings()
        }
        return service!
    }
    
}
