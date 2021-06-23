//
//  GroupedTableView.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class GroupedTableView: UITableView {
    
    private static let cellIdentifier = "SystemCell"
    
    var sections: [TableViewSectionViewModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        registerCells()
    }
    
    private func setup() {
        dataSource = self
        delegate = self
    }
    
    private func registerCells() {
        register(UITableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
    }
    
}

extension GroupedTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = sections[indexPath.section].cells[indexPath.row]
        return viewModel.view(in: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
}

extension GroupedTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].cells[indexPath.row].select()
    }
}
