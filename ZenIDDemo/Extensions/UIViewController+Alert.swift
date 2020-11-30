//
//  UIViewController+Alert.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 10/07/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String?, message: String?, ok: (() -> Void)? = nil) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        // iPad style
        self.addActionSheetForiPad(actionSheet: alert)
        
        // add OK
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { ø in ok?() }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    fileprivate func addActionSheetForiPad(actionSheet: UIViewController) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}

