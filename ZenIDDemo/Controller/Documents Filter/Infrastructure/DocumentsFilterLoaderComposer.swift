//
//  DocumentsFilterLoaderComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class DocumentsFilterLoaderComposer {
    
    private static var service: (DocumentsFilterLoader & DocumentsFilterSaver & DocumentsFilterDeleter)?
    
    static func compose() -> DocumentsFilterLoader & DocumentsFilterSaver & DocumentsFilterDeleter {
        if service == nil {
            service = UserDefaultsDocumentsFilter()
        }
        return service!
    }
    
}
