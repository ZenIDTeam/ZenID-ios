//
//  DocumentsFilterCoordinator.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentsFilterCoordinator {
    
    private var rootViewController: UIViewController!
    
    private var selectionCompletion: ((SelectionItemViewModel) -> Void)?
    
    init() {
        
    }
    
    func start() -> UIViewController {
        let viewController = DocumentsFilterComposer.compose(
            loader: DocumentsFilterLoaderComposer.compose(),
            deleter: DocumentsFilterLoaderComposer.compose(),
            saver: DocumentsFilterLoaderComposer.compose(),
            coordinator: self
        )
        rootViewController = viewController
        return viewController
    }
    
    private func present(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        rootViewController.present(viewController, animated: true, completion: nil)
    }
    
    private func show(viewController: UIViewController) {
        rootViewController.presentedViewController?.show(viewController, sender: self)
    }
    
    private func closeLastController() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    private func popLastController() {
        (rootViewController.presentedViewController as? UINavigationController)?.popViewController(animated: true)
    }
    
}

extension DocumentsFilterCoordinator: DocumentsFilterCoordinable {
    func documentsFilterAddNewDocumentFilter() {
        let viewController = AddDocumentFilterComposer.compose(
            saver: DocumentsFilterLoaderComposer.compose(),
            coordinator: self
        )
        present(viewController: UINavigationController(rootViewController: viewController))
    }
}

extension DocumentsFilterCoordinator: AddDocumentFilterCoordinable {
    func addDocumentDidFinish() {
        closeLastController()
    }
    
    func addDocumentDidFail(error: Error) {
        
    }
    
    func addDocumentFilterOpenSelection(title: String, items: [SelectionItemViewModel], completion: @escaping (SelectionItemViewModel) -> Void) {
        let viewController = SelectionComposer.compose(
            viewModel: .init(
                title: title,
                data: items,
                delegate: self
            )
        )
        selectionCompletion = completion
        show(viewController: viewController)
    }
}

extension DocumentsFilterCoordinator: SelectionDelegate {
    func selectionDidSelect(viewModel: SelectionItemViewModel) {
        selectionCompletion?(viewModel)
        selectionCompletion = nil
        popLastController()
    }
}
