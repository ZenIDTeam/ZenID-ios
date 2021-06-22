//
//  SelectionViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class SelectionViewModel {
    
    let title: String
    let data: [SelectionItemViewModel]
    private let delegate: SelectionDelegate
    
    init(title: String, data: [SelectionItemViewModel], delegate: SelectionDelegate) {
        self.title = title
        self.data = data
        self.delegate = delegate
    }
    
    func didSelect(indexPath: IndexPath) {
        delegate.selectionDidSelect(viewModel: data[indexPath.row])
    }
    
}
