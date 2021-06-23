//
//  LogoutTableCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class LogoutTableCellController: TableCellController {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "SystemCell")
        cell.textLabel?.text = NSLocalizedString("btn-logout", comment: "")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func select() {
        viewController.confirm(title: nil, message: NSLocalizedString("alert-clear-credentials", comment: ""), ok: { [weak self] in
            self?.resetCredentials()
        })
    }
    
    private func resetCredentials() {
        Credentials.shared.clear()
        Haptics.shared.success()
    }
    
}

