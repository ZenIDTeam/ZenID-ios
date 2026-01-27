//
//  DocumentViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID
import UIKit

@MainActor
class DocumentViewModel: InvestigatingViewModel<DocumentVerifier> {

    private let config: DocumentConfiguration = .load(key: storageConfiguration, defaultValue: DocumentConfiguration(country: .cz))!

    override func createVerifier() throws -> DocumentVerifier {
        let verifier = try ZenIDManager.documentVerifier(
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

        // Setup NFC with custom retry prompt
        verifier.setupNfcWithRetry(showRetryPrompt: { [weak self] (attempt: Int, maxAttempts: Int, error: Error, skipAllowed: Bool) in
            guard let self = self else { return false }
            return await self.showNfcRetryPrompt(attempt: attempt, maxAttempts: maxAttempts, error: error, skipAllowed: skipAllowed)
        })

        return verifier
    }

    // MARK: - NFC Retry Handling

    @Published var showNfcRetryButton = false
    private var nfcRetryContinuation: CheckedContinuation<Bool, Never>?

    @MainActor
    private func showNfcRetryPrompt(attempt: Int, maxAttempts: Int, error: Error, skipAllowed: Bool) async -> Bool {
        OSLogger.app.info("DocumentViewModel: NFC failed (attempt \(attempt)/\(maxAttempts)), showing retry button")

        // Show retry button in UI
        showNfcRetryButton = true

        // Wait for user action
        let shouldRetry = await withCheckedContinuation { continuation in
            self.nfcRetryContinuation = continuation
        }

        showNfcRetryButton = false
        return shouldRetry
    }

    func retryNfc() {
        OSLogger.app.info("DocumentViewModel: User clicked retry")
        nfcRetryContinuation?.resume(returning: true)
        nfcRetryContinuation = nil
    }

    func cancelNfc() {
        OSLogger.app.info("DocumentViewModel: User cancelled NFC")
        nfcRetryContinuation?.resume(returning: false)
        nfcRetryContinuation = nil
    }

    override func setup() async {
        guard scanningState == .setup else { return }

        ZenIDManager.selectProfile(Profile.current)
        ZenIDManager.setInsets(insets: UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0))

        OSLogger.app.debug("DocumentViewModel setup")

        // Start verifier automatically after setup
        // Note: ZenIDView creates and registers the camera view with ZenIDManager
        if let zenIDView = ZenIDManager.zenIDView {
            startVerifier(with: zenIDView)
        }
    }
}
