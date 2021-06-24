//
//  SettingsCoordinator.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SettingsCoordinator {
    
    private var rootViewController: UINavigationController!
    
    private var documentsFilterCoordinator: DocumentsFilterCoordinator?
    
    init() {
        
    }
    
    func start() -> UIViewController {
        let settingsViewController = SettingsComposer.compose(coordinator: self)
        rootViewController = UINavigationController(rootViewController: settingsViewController)
        rootViewController?.modalPresentationStyle = .fullScreen
        return rootViewController
    }
    
    private func show(viewController: UIViewController) {
        rootViewController.show(viewController, sender: self)
    }
    
}

extension SettingsCoordinator: SettingsCoordinable {
    func settingsDidFinish() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func settingsOpenDocumentsFilter() {
        documentsFilterCoordinator = DocumentsFilterCoordinator()
        show(viewController: documentsFilterCoordinator!.start())
    }
    
    func settingsOpenDocumentVerifierSettings() {
        let viewController = DocumentVerifierSettingsComposer.compose(
            loader: DocumentVerifierSettingsLoaderComposer.compose(),
            updater: DocumentVerifierSettingsLoaderComposer.compose()
        )
        show(viewController: viewController)
    }
        
}
