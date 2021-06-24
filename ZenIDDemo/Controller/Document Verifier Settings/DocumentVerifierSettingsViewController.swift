//
//  DocumentVerifierSettingsViewController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentVerifierSettingsViewController: UIViewController {
    
    var viewModel: DocumentVerifierSettingsViewModel!
    
    var contentView: DocumentVerifierSettingsView {
        view as! DocumentVerifierSettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModel.reloadData()
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("settings-document-verifier-settings", comment: "")
    }
    
}
