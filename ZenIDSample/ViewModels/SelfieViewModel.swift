//
//  SelfieViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID

@MainActor
class SelfieViewModel: InvestigatingViewModel<SelfieVerifier> {

    override func createVerifier() throws -> SelfieVerifier {
        try ZenIDManager.selfieVerifier()
    }

    override func setup() async {
        guard scanningState == .setup else { return }

        ZenIDManager.selectProfile(Profile.current)

        OSLogger.app.debug("SelfieViewModel setup")

        if let zenIDView = ZenIDManager.zenIDView {
            startVerifier(with: zenIDView)
        }
    }
}
