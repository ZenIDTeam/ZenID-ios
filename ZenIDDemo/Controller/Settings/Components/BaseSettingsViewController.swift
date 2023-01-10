//
//  BaseSettingsViewController.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 29.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import Foundation
import UIKit

open class BaseSettingsViewController: UIViewController {
    weak var tableView: GroupedTableView!

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        setupNavigationBar()
        setupUI()
    }

    open func setupNavigationBar() {
//        title = NSLocalizedString("settings-faceliveness-verifier-settings", comment: "")
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }

    open func setupUI() {
        let tableView = GroupedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = .zero
        tableView.layoutMargins = .zero
        view.addSubview(tableView)
        self.tableView = tableView
        let constraints = tableView.constraintsForAnchoringTo(boundsOf: view)
        NSLayoutConstraint.activate(constraints)
    }
}
