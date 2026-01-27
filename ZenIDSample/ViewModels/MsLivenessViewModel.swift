//
//  MsLivenessViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 30.07.2025.
//  Copyright © 2025 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID
import Combine

@MainActor
class MsLivenessViewModel: InvestigatingViewModel<MSLivenessVerifier> {

    /// Access to coordinator for MS Liveness UI presentation
    var coordinator: MSLivenessCoordinator? {
        self.verifier?.coordinator
    }

    override func createVerifier() throws -> MSLivenessVerifier {
        try ZenIDManager.msLivenessVerifier()
    }

    override func setup() async {
        guard scanningState == .setup else { return }

        ZenIDManager.selectProfile(Profile.current)

        OSLogger.app.debug("MsLivenessViewModel setup")

        if let zenIDView = ZenIDManager.zenIDView {
            startVerifier(with: zenIDView)
        }
    }
}
