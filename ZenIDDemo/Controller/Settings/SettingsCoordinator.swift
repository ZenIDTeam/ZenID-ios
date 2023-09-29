//
//  SettingsCoordinator.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class SettingsCoordinator {
    
    private var rootViewController: NavigationController!
    private var documentsFilterCoordinator: DocumentsFilterCoordinator?
    
    init() {
        
    }
    
    func start() -> UIViewController {
        let settingsViewController = SettingsComposer.compose(
            selfieSelectionLoader: SelfieSelectionLoaderComposer.compose(),
            configService: ConfigServiceComposer.compose(),
            coordinator: self
        )
        rootViewController = NavigationController(rootViewController: settingsViewController)
        rootViewController?.modalPresentationStyle = .fullScreen
        return rootViewController
    }
    
    private func show(viewController: UIViewController) {
        rootViewController.show(viewController, sender: self)
    }
    
    private func dismissLastViewController() {
        rootViewController.popViewController(animated: true)
    }
    
    private func dismissViewController() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsCoordinator: SettingsCoordinable {
    func settingsDidFinish() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    func settingsOpenSelfieSelection() {
        let viewController = SelfieSelectionComposer.compose(
            saver: SelfieSelectionLoaderComposer.compose(),
            coordinator: self
        )
        show(viewController: viewController)
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
    
    func settingsOpenFaceLivenessVerifierSettings() {
        let viewController = LivenessVerifierSettingsComposer.compose(
            loader: LivenessVerifierSettingsLoaderComposer.compose(),
            updater: LivenessVerifierSettingsLoaderComposer.compose()
        )
        show(viewController: viewController)
    }
    
    func settingsDidLogout() {
        dismissViewController()
    }
    
    func settingsNfcSettingsPreview() { 
        let settings = DocumentVerifierNfcValidatorSettingsComposer().compose()
        let viewController = NfcSettingsPreviewViewController(settings: settings)
        show(viewController: viewController)
    }
}

extension SettingsCoordinator: SelfieSelectionCoordinable {
    func selfieSelectionDidFinish() {
        dismissLastViewController()
    }
}
