//
//  BasicTableCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class BasicTableCellController: TableCellController {
    
    private let viewModel: BasicTableCellViewModel
    
    init(viewModel: BasicTableCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SystemCell", for: indexPath)
        cell.textLabel?.text = viewModel.title
        cell.accessoryType = viewModel.action == nil ? .none : .disclosureIndicator
        return cell
    }
    
    func select() {
        viewModel.action?()
    }
    
}
