//
//  BasicTableCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


class BasicTableCellController: TableCellController {
    
    private var viewModel: BasicTableCellViewModel
    
    init(viewModel: BasicTableCellViewModel) {
        self.viewModel = viewModel
    }
    
    func update(viewModel: BasicTableCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "SystemCell")
        cell.textLabel?.text = viewModel.title
        cell.detailTextLabel?.text = viewModel.detail
        cell.accessoryType = viewModel.action == nil ? .none : .disclosureIndicator
        return cell
    }
    
    func select() {
        viewModel.action?()
    }
    
}
