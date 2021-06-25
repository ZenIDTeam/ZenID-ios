//
//  SelfieSelectionComposer.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class SelfieSelectionComposer {
    
    static func compose(saver: SelfieSelectionSaver, coordinator: SelfieSelectionCoordinable) -> SelectionViewController {
        let viewModel = resolve(saver: saver)
        let viewController = SelectionComposer.compose(
            viewModel: resolve(viewModel: viewModel)
        )
        viewModel.onChange = { _ in
            coordinator.selfieSelectionDidFinish()
        }
        return viewController
    }
    
    private static func resolve(viewModel: SelfieSelectionViewModel) -> SelectionViewModel {
        .init(
            title: NSLocalizedString("btn-face-mode", comment: ""),
            data: viewModel.items,
            delegate: viewModel
        )
    }
    
    private static func resolve(saver: SelfieSelectionSaver) -> SelfieSelectionViewModel {
        .init(saver: saver)
    }
    
}
