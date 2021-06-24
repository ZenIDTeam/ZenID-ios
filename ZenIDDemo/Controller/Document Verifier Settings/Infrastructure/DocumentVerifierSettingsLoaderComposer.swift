//
//  DocumentVerifierSettingsLoaderComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class DocumentVerifierSettingsLoaderComposer {
    
    private static var service: (DocumentVerifierSettingsLoader & DocumentVerifierSettingsUpdater)?
    
    static func compose() -> DocumentVerifierSettingsLoader & DocumentVerifierSettingsUpdater {
        if service == nil {
            service = InMemoryDocumentVerifierSettings()
        }
        return service!
    }
    
}
