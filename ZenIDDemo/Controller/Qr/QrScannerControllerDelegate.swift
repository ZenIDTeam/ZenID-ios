//
//  QrScannerControllerDelegate.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 27/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import UIKit

/// This protocol defines QR scnanner events
public protocol QrScannerControllerDelegate: AnyObject {
    func qrSuccess(_ controller: UIViewController, scanDidComplete result: String, completion: (() -> Void)?)
    func qrFail(_ controller: UIViewController, error: String)
    func qrCancel(_ controller: UIViewController)
}
