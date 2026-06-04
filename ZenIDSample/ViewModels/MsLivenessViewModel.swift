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

    /// Coordinator for MS Liveness UI presentation. Owned by the view model and wired into the
    /// verifier on creation, so SwiftUI views can observe it from body-build time.
    let coordinator = MSLivenessCoordinator()

    override func createVerifier() throws -> MSLivenessVerifier {
        try ZenIDManager.msLivenessVerifier(coordinator: coordinator)
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
