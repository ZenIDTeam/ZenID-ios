//
//  SelfieSelectionViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 25.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation


final class SelfieSelectionViewModel {
    
    var onChange: ((FaceMode?) -> Void)?
    
    let items: [SelectionItemViewModel]
    
    private let saver: SelfieSelectionSaver
    
    init(saver: SelfieSelectionSaver) {
        self.saver = saver
        
        items = [
            .init(title: NSLocalizedString("settings-selfie-none", comment: "")),
            .init(title: NSLocalizedString("settings-selfie-match", comment: "")),
            .init(title: NSLocalizedString("settings-selfie-liveness", comment: "")),
        ]
    }
    
}

extension SelfieSelectionViewModel: SelectionDelegate {
    func selectionDidSelect(viewModel: SelectionItemViewModel) {
        guard let index = items.firstIndex(where: { $0.title == viewModel.title }) else {
            return
        }
        let faceMode = FaceMode(index: index - 1)
        onChange?(faceMode)
        saver.save(mode: faceMode) { [weak self] result in
            self?.handleSaveResult(result: result)
        }
    }
    
    private func handleSaveResult(result: SelfieSelectionSaver.Result) {
        switch result {
        case .success:
            break
        case .failure:
            break
        }
    }
}
