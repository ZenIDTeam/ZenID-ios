//
//  ToastView.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 26/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

class ToastView: UIView {
    
    var toastLabel: UILabel = {
        let toastLabel = UILabel()
        toastLabel.isUserInteractionEnabled = false
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0    
        toastLabel.textColor = .zenPurpleDark
        return toastLabel
    }()

    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        alpha = 0
        backgroundColor = .zenGreen
        
        addSubview(toastLabel)
        toastLabel.anchor(top: layoutMarginsGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
    }
    
    func show() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 3.0, options: .curveEaseIn, animations: {
                self.alpha = 0
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        Log.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
}
