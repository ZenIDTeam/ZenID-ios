//
//  FaceLivenessViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID

@MainActor
class FaceLivenessViewModel: InvestigatingViewModel<FaceLivenessVerifier> {

    override func createVerifier() throws -> FaceLivenessVerifier {
        try ZenIDManager.faceLivenessVerifier(
            settings: .init(
                showSmileAnimation: true
            )
        )
    }

    override func setup() async {
        guard scanningState == .setup else { return }

        ZenIDManager.selectProfile(Profile.current)

        OSLogger.app.debug("FaceLivenessViewModel setup")

        if let zenIDView = ZenIDManager.zenIDView {
            startVerifier(with: zenIDView)
        }
    }
}
