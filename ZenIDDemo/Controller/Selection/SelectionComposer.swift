//
//  SelectionComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//


import UIKit


final class SelectionComposer {
    
    static func compose(viewModel: SelectionViewModel) -> SelectionViewController {
        let viewController = UIStoryboard(name: "Selection", bundle: nil).instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
        viewController.viewModel = viewModel
        viewController.contentView.tableView.sections = [.init(title: nil, cells: viewController.viewModel.data.map({ itemViewModel in
            BasicTableCellController(viewModel: .init(title: itemViewModel.title, action: { [weak viewController] in
                viewController?.viewModel.didSelect(item: itemViewModel)
            }))
        }))]
        return viewController
    }
    
}
