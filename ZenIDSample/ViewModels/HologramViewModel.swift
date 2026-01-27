//
//  HologramViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID

@MainActor
class HologramViewModel: InvestigatingViewModel<HologramVerifier> {

    private let config: DocumentConfiguration = .load(key: storageConfiguration, defaultValue: DocumentConfiguration(country: .cz))!

    override func createVerifier() throws -> HologramVerifier {
        try ZenIDManager.hologramVerifier(
            settings: .init(
                viewportHeightCm: nil,
                enableAimingCircle: false,
                showTimer: false,
                drawOutline: true,
                acceptableInput: .init(possibleDocuments: [
                    DocumentFilter(
                        role: config.role,
                        country: config.country,
                        page: config.page,
                        documentCode: nil,
                        modelID: ""
                    )
                ])
            )
        )
    }

    override func setup() async {
        guard scanningState == .setup else { return }

        OSLogger.app.debug("HologramViewModel setup")

        if let zenIDView = ZenIDManager.zenIDView {
            startVerifier(with: zenIDView)
        }
    }
}
