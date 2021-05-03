//
//  AppDelegate.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ZenIDLogger.shared.startLogging()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: ChoiceViewController())
        self.window?.makeKeyAndVisible()
        configureNavigationBar()

        return true
    }

    private func configureNavigationBar() {
        // Cusomize global appearance
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .zenGreen  // Back buttons and such
        navigationBarAppearace.barStyle = .black
        navigationBarAppearace.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.zenTextLight,
            NSAttributedString.Key.font: UIFont.topLabel
        ]
    }
}

