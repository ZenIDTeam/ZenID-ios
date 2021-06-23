//
//  SettingsViewController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModel!
    
    private var contentView: SettingsView {
        view as! SettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("settings-title", comment: "")
        contentView.tableView.sections = viewModel.sections
    }
    
    private func setupNavigationBar() {
        let closeBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(closeButtonPressed)
        )
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }
    
    @objc
    private func closeButtonPressed() {
        viewModel.finish()
    }
    
}
