//
//  AddDocumentFilterViewController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class AddDocumentFilterViewController: UIViewController {
    
    var viewModel: AddDocumentFilterViewModel!
    
    var contentView: AddDocumentFilterContentView {
        view as! AddDocumentFilterContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("document-filter-title", comment: "")
        navigationItem.leftBarButtonItem = cancelBarButton()
        navigationItem.rightBarButtonItem = saveBarButton()
    }
    
    private func cancelBarButton() -> UIBarButtonItem {
        UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonPressed)
        )
    }
    
    private func saveBarButton() -> UIBarButtonItem {
        UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonPressed)
        )
    }
    
    @objc
    private func cancelButtonPressed() {
        viewModel.cancel()
    }
    
    @objc
    private func saveButtonPressed() {
        viewModel.save()
    }
    
}
