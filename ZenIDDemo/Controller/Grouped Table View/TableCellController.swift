//
//  TableViewCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


protocol TableCellController {
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
}
