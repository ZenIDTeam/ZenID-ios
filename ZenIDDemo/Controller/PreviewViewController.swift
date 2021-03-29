//
//  PreviewViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

final class PreviewViewController: UIViewController {
    private let topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .zenTextLight
        label.font = .topLabel
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .zenTextLight
        label.font = .messageLabel
        return label
    }()
    
    private let controlView = UIView()
    private let imageView = UIImageView()
    
    private let saveButton = Buttons.Camera.save
    private let deleteButton = Buttons.Camera.delete
    
    var saveAction: (()->())?
    var dismissAction: (()->())?
    
    init(title: String, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        topLabel.text = title
        messageLabel.text = "title-preview".localized
    }
    
    required init?(coder aDecoder: NSCoder) {
        Log.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }    

    private func setupView() {
        view.backgroundColor = UIColor.black
        
        // Top title
        view.addSubview(topLabel)
        topLabel.anchor(top: view.layoutMarginsGuide.topAnchor, left: nil, bottom: nil, right: nil)
        topLabel.centerX(to: view)
        
        // Message
        view.addSubview(messageLabel)
        messageLabel.anchor(top: topLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10)
        messageLabel.centerX(to: view)
        
        // Camera view
        view.addSubview(imageView)
        imageView.anchor(top: messageLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15)
        
        // Control view
        view.addSubview(controlView)
        controlView.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor, height: 96)
        
        // Save button
        controlView.addSubview(saveButton)
        saveButton.centerX(to: controlView)
        saveButton.centerY(to: controlView)
        
        // Delete button
        controlView.addSubview(deleteButton)
        deleteButton.anchor(top: nil, left: saveButton.rightAnchor, bottom: nil, right: nil, paddingLeft: 50)
        deleteButton.centerY(to: controlView)
    }
    
    private func setupBindings() {
        saveButton.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(close(sender:)), for: .touchUpInside)
    }
    
    @objc func close(sender: UIButton) {
        if sender == saveButton {
            saveAction?()
        }
        else {
            dismissAction?()
        }
        dismiss(animated: true, completion: nil)
    }
}
