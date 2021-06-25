//
//  SelfieTableCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SelfieTableCellController: TableCellController {
    
    private let viewModel: SelfieTableViewModel
    
    init(viewModel: SelfieTableViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "SystemCell")
        cell.textLabel?.text = NSLocalizedString("btn-face-mode", comment: "")
        cell.detailTextLabel?.text = viewModel.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func select() {
        viewModel.action()
    }
    
}


