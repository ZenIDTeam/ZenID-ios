//
//  ContanctTableCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class ContactTableCellController: TableCellController {
    
    init() {
        
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "SystemCell")
        cell.textLabel?.text = NSLocalizedString("btn-contact", comment: "")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func select() {
        if let emailURL = URL(string: "mailto:\(ZenConstants.contactEmail)"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }
    
}

