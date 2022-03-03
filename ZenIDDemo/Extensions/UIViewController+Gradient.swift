//
//  UIViewController+Gradient.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 19/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit


extension UIViewController {
    @discardableResult
    func applyDefaultGradient() -> CALayer {
        view.createGradientLayer(colors: [UIColor.zenPurple.cgColor, UIColor.zenGreen.cgColor], angle: 29)
    }

    @discardableResult
    func applyPathGradient() -> CALayer {
        let startHeight: CGFloat = 190 - (UIDevice.isPhoneSE ? 40 : 0)
        let endHeight: CGFloat = 190 - (UIDevice.isPhoneSE ? 40 : 0)
        return view.setPartialGradient(colors: [UIColor.zenPurple.cgColor, UIColor.zenGreen.cgColor], angle: 29, start: startHeight, end: endHeight)
    }
}
