//
//  AppDelegate.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import RecogLib_iOS
import UIKit

struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIDeviceOrientation) {
        let rotation: UIInterfaceOrientation
        switch rotateOrientation {
        case .landscapeLeft: rotation = .landscapeRight
        case .landscapeRight: rotation = .landscapeLeft
        default: rotation = .portrait
        }
        lockOrientation(orientation)
        UIDevice.current.setValue(rotation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ZenIDLogger.shared.startLogging()

        window = UIWindow(frame: UIScreen.main.bounds)
        let menuViewController = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "ChoiceViewController")
//        let menuViewController = LivenessVerifierSettingsComposer.compose(loader: LivenessVerifierSettingsLoaderComposer.compose(), updater: LivenessVerifierSettingsLoaderComposer.compose())

        window?.rootViewController = NavigationController(rootViewController: menuViewController)
        window?.makeKeyAndVisible()
        configureNavigationBar()

        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        orientationLock
    }

    private func configureNavigationBar() {
        // Cusomize global appearance
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .zenGreen // Back buttons and such
        navigationBarAppearace.barStyle = .black
        navigationBarAppearace.barTintColor = .black
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.backgroundColor = .black
        navigationBarAppearace.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.zenTextLight,
            NSAttributedString.Key.font: UIFont.topLabel
        ]
    }
}
