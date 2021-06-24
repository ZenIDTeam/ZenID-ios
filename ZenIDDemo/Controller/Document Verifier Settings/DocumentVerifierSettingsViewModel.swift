//
//  DocumentVerifierSettingsViewModel.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS


final class DocumentVerifierSettingsViewModel {
    
    var onUpdate: (([DocumentVerifierSettingsValueViewModel]) -> Void)?
    
    private let loader: DocumentVerifierSettingsLoader
    private let updater: DocumentVerifierSettingsUpdater
    
    init(loader: DocumentVerifierSettingsLoader, updater: DocumentVerifierSettingsUpdater) {
        self.loader = loader
        self.updater = updater
    }
    
    func reloadData() {
        loader.load { [weak self] result in
            self?.handleLoadResult(result: result)
        }
    }
    
    private func handleLoadResult(result: DocumentVerifierSettingsLoader.Result) {
        switch result {
        case let .success(settings):
            update(settings: settings)
        case .failure:
            break
        }
    }
    
    private func update(settings: DocumentVerifierSettings) {
        let items: [DocumentVerifierSettingsValueViewModel] = [
            .init(
                title: NSLocalizedString("document-verifier-settings-specular", comment: ""),
                value: Float(settings.specularAcceptableScore), min: 0.0, max: 100.0,
                onChange: { [weak self] value in
                    self?.updater.update(specularAcceptableScore: Int(value), completion: { [weak self] result in
                        self?.handleUpdateResult(result: result)
                    })
                }
            ),
            .init(
                title: NSLocalizedString("document-verifier-settings-blur", comment: ""),
                value: Float(settings.documentBlurAcceptableScore), min: 0.0, max: 100.0,
                onChange: { [weak self] value in
                    self?.updater.update(documentBlurAcceptableScore: Int(value), completion: { [weak self] result in
                        self?.handleUpdateResult(result: result)
                    })
                }
            ),
            .init(
                title: NSLocalizedString("document-verifier-settings-blur-tolerance", comment: ""),
                value: Float(settings.timeToBlurMaxToleranceInSeconds), min: 0.0, max: 100.0,
                onChange: { [weak self] value in
                    self?.updater.update(timeToBlurMaxToleranceInSeconds: Int(value), completion: { [weak self] result in
                        self?.handleUpdateResult(result: result)
                    })
                }
            ),
        ]
        onUpdate?(items)
    }
    
    private func handleUpdateResult(result: DocumentVerifierSettingsUpdater.Result) {
        switch result {
        case .success:
            break
        case .failure:
            break
        }
    }
    
}
