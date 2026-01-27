//
//  LicencePlateViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 01.08.2025.
//  Copyright © 2025 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID

@MainActor
class LicencePlateViewModel: InvestigatingViewModel<LicencePlateVerifier> {

    override func createVerifier() throws -> LicencePlateVerifier {
        try ZenIDManager.licencePlateVerifier()
    }

    override func setup() async {
        guard scanningState == .setup else { return }

        ZenIDManager.selectProfile(Profile.current)

        OSLogger.app.debug("LicencePlateViewModel setup")

        if let zenIDView = ZenIDManager.zenIDView {
            startVerifier(with: zenIDView)
        }
    }
}
