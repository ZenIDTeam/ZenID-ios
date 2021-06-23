//
//  DocumentsFilterCoordinator.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentsFilterCoordinator {
    
    init() {
        
    }
    
    func start() -> UIViewController {
        let viewController = DocumentsFilterComposer.compose(
            loader: DocumentsFilterLoaderComposer.compose(),
            deleter: DocumentsFilterLoaderComposer.compose(),
            saver: DocumentsFilterLoaderComposer.compose(),
            coordinator: self
        )
        return viewController
    }
    
}

extension DocumentsFilterCoordinator: DocumentsFilterCoordinable {
    func documentsFilterAddNewDocumentFilter() {
        
    }
}
