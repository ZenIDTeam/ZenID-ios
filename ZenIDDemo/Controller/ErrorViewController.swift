//
//  ErrorViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 20/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Common
import UIKit

final class ErrorViewController: BaseInfoViewController {
    private let closeButton = Buttons.ok

    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .zenTextLight
        label.font = .messageLabel
        label.numberOfLines = 0
        label.text = "msg-network-error".localized
        label.textAlignment = .center
        return label
    }()

    var documentType: DocumentType? { didSet { setupImageBackground(documentType: documentType) }}

    override func setupBackground() {
        _ = view.createGradientLayer(colors: [UIColor.zenRedDark.cgColor, UIColor.zenRed.cgColor], angle: 29)
    }

    override func setupView() {
        super.setupView()
        image = #imageLiteral(resourceName: "Icon-Error")
        bottomLabel.textColor = .zenTextLight
        bottomLabel.text = "title-error".localized

        view.addSubview(messageLabel)
        messageLabel.anchor(top: bottomLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, width: 250)
        messageLabel.centerX(to: view)

        view.addSubview(closeButton)
        closeButton.anchor(top: nil, left: nil, bottom: view.layoutMarginsGuide.bottomAnchor, right: nil, paddingBottom: 20)
        closeButton.centerX(to: view)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }

    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }
}
