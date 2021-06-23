//
//  DocumentsFilterViewController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentsFilterViewController: UIViewController {
    
    var viewModel: DocumentsFilterViewModel!
    
    var contentView: DocumentsFilterContentView {
        view as! DocumentsFilterContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadData()
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("settings-filter", comment: "")
        
        let addNewFilterBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewFilterPressed)
        )
        navigationItem.rightBarButtonItem = addNewFilterBarButtonItem
    }
    
    @objc
    private func addNewFilterPressed() {
        viewModel.addNewFilter()
    }
    
}
