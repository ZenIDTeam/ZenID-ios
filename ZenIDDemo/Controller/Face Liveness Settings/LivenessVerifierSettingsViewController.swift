//
//  FaceLivenessSettingsViewController.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import UIKit

final class LivenessVerifierSettingsViewController: BaseSettingsViewController {
    var viewModel: LivenessVerifierSettingsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadData()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = NSLocalizedString("settings-faceliveness-verifier-settings", comment: "")
    }
}
