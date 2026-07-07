//
//  MSLivenessSwiftUIHelper.swift
//  ZenID Sample
//
//  Created by ZenID SDK on 08.10.2025.
//  Copyright © 2025 ZenID s.r.o. All rights reserved.
//
//  This is SAMPLE CODE that customers can copy into their projects.
//  It is NOT part of the ZenID SDK (since Azure is optional).
//

import SwiftUI
import ZenID
import AzureAIVisionFaceUI
import Combine

/// SwiftUI wrapper for Azure Liveness UI driven by ``MSLivenessCoordinator``.
///
/// Observes the coordinator's `presentation` request and presents Azure's
/// `FaceLivenessDetectorView` in a `fullScreenCover` keyed on the request's id, so each retry
/// gets a clean dismiss-then-represent transition without timing hacks.
///
/// Usage:
/// ```swift
/// @StateObject var coordinator = MSLivenessCoordinator()
///
/// var body: some View {
///     ZStack {
///         Color.black.ignoresSafeArea()
///         ZenIDView()
///         // ... your other UI
///     }
///     .msLiveness(coordinator: coordinator)
/// }
/// ```
struct MSLivenessSwiftUIHelper: View {
    @ObservedObject var coordinator: MSLivenessCoordinator
    @State private var result: LivenessDetectionResult?

    var body: some View {
        Color.clear
            .fullScreenCover(item: Binding(
                get: { coordinator.presentation },
                // Setter is a no-op: dismissal is driven by coordinator.complete(...) which
                // clears `presentation` from the SDK side.
                set: { _ in }
            )) { request in
                FaceLivenessDetectorView(
                    result: $result,
                    sessionAuthorizationToken: request.token
                )
                .onChange(of: result) { newResult in
                    guard let newResult else { return }
                    self.result = nil  // reset for next attempt
                    switch newResult {
                    case .success:
                        coordinator.complete(success: true)
                    case .failure(let error):
                        coordinator.complete(success: false,
                                            error: String(describing: error.livenessError))
                    }
                }
            }
    }
}

/// View extension for easy integration
extension View {
    /// Add Azure Liveness support to your view.
    ///
    /// Pass the coordinator you own (typically `@StateObject`) — it does not need to come from
    /// our `MSLivenessViewModel`. Wire the same coordinator into the verifier via
    /// ``ZenIDManager/msLivenessVerifier(settings:coordinator:)``.
    func msLiveness(coordinator: MSLivenessCoordinator?) -> some View {
        ZStack {
            self
            if let coordinator {
                MSLivenessSwiftUIHelper(coordinator: coordinator)
            }
        }
    }
}
