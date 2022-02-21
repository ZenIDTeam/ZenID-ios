//
//  BusyViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 10/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

final class BusyViewController: BaseInfoViewController {
    override var shouldAutorotate: Bool {
        false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    private let onImage = #imageLiteral(resourceName: "BulbOn")
    private let offImage = #imageLiteral(resourceName: "BulbOff")

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomTitle = "title-busy".localized
        setupAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imageView.alpha = 0
        }, completion: nil)
    }
    
    private func setupAnimation() {
        imageView.image = onImage
        let offImageView = UIImageView(image: offImage)
        imageParent.insertSubview(offImageView, at: 0)
        offImageView.centerX(to: imageParent)
        offImageView.centerY(to: imageParent)
    }
}
