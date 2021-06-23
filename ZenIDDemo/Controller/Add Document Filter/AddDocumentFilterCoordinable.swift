//
//  AddDocumentFilterCoordinable.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


protocol AddDocumentFilterCoordinable {
    func addDocumentDidFinish()
    func addDocumentDidFail(error: Error)
    func addDocumentFilterOpenSelection(title: String, items: [SelectionItemViewModel], completion: @escaping (SelectionItemViewModel) -> Void)
}
