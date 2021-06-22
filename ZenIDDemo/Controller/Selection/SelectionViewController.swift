//
//  SelectionViewController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 22.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SelectionViewController: UIViewController {
    
    var viewModel: SelectionViewModel!
    
    var contentView: SelectionView {
        view as! SelectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func setupNavigation() {
        title = viewModel.title
    }
    
}
