//
//  LoginViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import Combine
import ZenID

@MainActor class LoginViewModel: ObservableObject {

    @Published var isInitializing: Bool = false

    /// Process data from QR code and authorize with new server.
    ///
    /// - Parameter qrCode: QR code data as String.
    /// - Returns: `True` if QR code is valid and authorization succeeds.
    func processData(from qrCode: String) async -> Bool {
        let data = qrCode.split(separator: " ")
        guard data.count == 2,
            let urlPath = data.first,
            let url = URL(string: String(urlPath)),
            let key = data.last
        else {
            Haptics.shared.playError()
            return false
        }

        do {
            try Credentials(url: url, key: String(key)).save(key: storageCredentials)

            // Clear verifier cache since server is changing
            ZenIDManager.clearVerifierCache()

            // Authorize immediately with new server to load fresh license data
            isInitializing = true
            do {
                let backendApi = ZenIDBackendApiImpl(baseURL: url, apiKey: String(key))
                try await ZenIDManager.initialize(backendApi: backendApi)
                // Authorization successful - profiles, verifiers, and documents are now loaded
                isInitializing = false
            } catch {
                // Authorization failed, but credentials are saved for retry
                isInitializing = false
                OSLogger.app.error("Failed to authorize with new server: \(error)")
                Haptics.shared.playError()
                return false
            }
        } catch {
            Haptics.shared.playError()
            return false
        }

        Haptics.shared.playSuccess()
        return true
    }

}
