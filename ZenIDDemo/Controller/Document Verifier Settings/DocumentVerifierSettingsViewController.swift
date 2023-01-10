//
//  DocumentVerifierSettingsViewController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit

final class DocumentVerifierSettingsViewController: BaseSettingsViewController {
    var viewModel: DocumentVerifierSettingsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadData()
    }

    override func setupNavigationBar() {
        title = NSLocalizedString("settings-document-verifier-settings", comment: "")
    }
}
