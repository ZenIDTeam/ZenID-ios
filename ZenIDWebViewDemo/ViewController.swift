//
//  ViewController.swift
//  ZenIDWebviewDemo
//
//  Created by Lukáš Gergel on 02.11.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var webViewOverlay: WebViewOverlay?

    override func viewDidLoad() {
        super.viewDidLoad()
        addWebViewOverlay()
    }

    func addWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        let webView = WebViewOverlay()
        webView.loadOffline()
        view.addSubview(webView)
        view.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        webViewOverlay = webView
    }

    func removeWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        webViewOverlay = nil
    }


}

