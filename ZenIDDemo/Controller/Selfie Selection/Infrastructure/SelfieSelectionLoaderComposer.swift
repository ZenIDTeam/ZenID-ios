//
//  SelfieSelectionLoaderComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 25.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class SelfieSelectionLoaderComposer {
    
    private static var service: (SelfieSelectionLoader & SelfieSelectionSaver)?
    
    static func compose() -> SelfieSelectionLoader & SelfieSelectionSaver {
        if service == nil {
            service = UserDefaultsSelfieSelection()
        }
        return service!
    }
    
}
