//
//  AppDelegate.swift
//  ZenIDWebviewDemo
//
//  Created by Lukáš Gergel on 02.11.2022.
//

import Foundation
import RecogLib_iOS
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appManager: AppManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        guard let windowScene = (application.connectedScenes.first as? UIWindowScene) else { return true }

        ZenIDLogger.shared.startLogging()

        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let appManager = AppManager(navigationController: navigationController)
        self.appManager = appManager
//        let window = UIWindow(windowScene: windowScene)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()

        appManager.start()
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
}
