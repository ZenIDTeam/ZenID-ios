//
//  DocumentFilterCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentFilterCellController: TableCellController {
    
    private let viewModel: DocumentViewModel
    private let deleter: DocumentFilterCellDeleter
    private let onDelete: () -> Void
    
    init(viewModel: DocumentViewModel, deleter: DocumentFilterCellDeleter, onDelete: @escaping () -> Void) {
        self.viewModel = viewModel
        self.deleter = deleter
        self.onDelete = onDelete
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentFilterTableCell", for: indexPath) as! DocumentFilterTableCell
        cell.roleValueLabel.text = viewModel.role
        cell.countryValueLabel.text = viewModel.country
        cell.pageValueLabel.text = viewModel.page
        return cell
    }
    
    func select() {
        do {
            try deleter.execute()
            onDelete()
        } catch {
            debugPrint(error)
        }
    }
}
