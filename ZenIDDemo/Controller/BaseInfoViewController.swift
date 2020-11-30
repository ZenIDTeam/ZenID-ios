//
//  BaseInfoViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 10/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

class BaseInfoViewController: UIViewController {
    
    var image: UIImage? { didSet { imageView.image = image }}
    var topTitle: String? { didSet { topLabel.text = topTitle?.uppercased() }}
    var bottomTitle: String? { didSet { bottomLabel.text = bottomTitle }}
    
    let imageParent = UIView()
    let imageView = UIImageView()
    let backgroundView = UIImageView()
    
    let topLabel: UILabel = {
        let topLabel = UILabel()
        topLabel.textColor = .zenTextLight
        topLabel.font = .topLabel
        topLabel.textAlignment = .center
        return topLabel
    }()
    
    let bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.textColor = .zenPurpleDark
        bottomLabel.font = .darkTitle
        bottomLabel.textAlignment = .center
        return bottomLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBackground()
        setupNavigationBar()
    }
    
    func setupView() {
        // Image parent view
        view.addSubview(imageParent)
        imageParent.centerX(to: view)
        imageParent.centerY(to: view)
        imageParent.addSubview(imageView)
        
        // Image background
        imageParent.addSubview(backgroundView)
        backgroundView.centerX(to: imageParent)
        backgroundView.centerY(to: imageParent)
        
        // Image view
        imageParent.addSubview(imageView)
        imageView.centerX(to: imageParent)
        imageView.centerY(to: imageParent)

        // Top title
        view.addSubview(topLabel)
        topLabel.anchor(top: nil, left: view.leftAnchor, bottom: imageView.topAnchor, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)

        // Bottom title
        view.addSubview(bottomLabel)
        bottomLabel.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right:  view.rightAnchor, paddingTop: 30, paddingLeft: 10, paddingRight: 10)
    }
    
    func setupBackground() {
        self.applyDefaultGradient()
    }
    
    func setupImageBackground(documentType: DocumentType?) {
        backgroundView.image = documentType?.backgoundImage ?? nil
    }
    
    private func setupNavigationBar() {
        // The navigation bar is transparent to show the gradient
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}
