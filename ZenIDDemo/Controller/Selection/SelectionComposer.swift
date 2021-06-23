//
//  SelectionComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//


import UIKit


final class SelectionComposer {
    
    static func compose(title: String, data: [SelectionItemViewModel], delegate: SelectionDelegate) -> SelectionViewController {
        let viewController = UIStoryboard(name: "Selection", bundle: nil).instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        viewController.viewModel = resolve(title: title, data: data, delegate: delegate)
        viewController.contentView.tableView.sections = [.init(title: nil, cells: viewController.viewModel.data.map({ itemViewModel in
            BasicTableCellController(viewModel: .init(title: itemViewModel.title, action: nil))
        }))]
        return viewController
    }
    
    private static func resolve(title: String, data: [SelectionItemViewModel], delegate: SelectionDelegate) -> SelectionViewModel {
        .init(title: title, data: data, delegate: delegate)
    }
    
}
