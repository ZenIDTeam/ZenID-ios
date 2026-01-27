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

/// Complete wrapper for Azure Liveness UI that handles all coordinator interaction.
///
/// This view handles ALL the complexity of:
/// - Observing coordinator token changes
/// - Presenting Azure's FaceLivenessDetectorView automatically when token is available
/// - Dismissing UI immediately when done
/// - Calling coordinator.complete() with the result
/// - Managing retry flow
///
/// Usage (simply add to your view):
/// ```swift
/// var body: some View {
///     ZStack {
///         ZenIDView()
///         // ... your other UI
///     }
///     .msLiveness(coordinator: viewModel.coordinator)
/// }
/// ```
struct MSLivenessSwiftUIHelper: View {
    let coordinator: MSLivenessCoordinator
    @State private var token: String?
    @State private var result: LivenessDetectionResult?
    @State private var isProcessingResult = false
    @State private var shouldPresent = false

    var body: some View {
        Color.clear
            .onReceive(coordinator.$token) { newToken in
                // Ignore token updates while processing result
                guard !isProcessingResult else { return }
                token = newToken
            }
            .onChange(of: token) { newToken in
                // Ignore if processing result
                guard !isProcessingResult else { return }

                // Update presentation flag after token has been set
                shouldPresent = (newToken != nil)
            }
            .fullScreenCover(isPresented: $shouldPresent) {
                makeAzureView()
            }
    }

    @ViewBuilder
    private func makeAzureView() -> some View {
        if let currentToken = token {
            FaceLivenessDetectorView(
                result: $result,
                sessionAuthorizationToken: currentToken
            )
            .environment(\.locale, Locale(identifier: ZenIDManager.getLanguageLocale()))
            .onChange(of: result) { result in
                guard let result else { return }

                // Dismiss UI immediately
                shouldPresent = false

                // Temporarily block token updates to prevent brief reappearance
                isProcessingResult = true
                token = nil

                Task { @MainActor in
                    // Give UI time to actually dismiss
                    try? await Task.sleep(nanoseconds: 100_000_000)

                    // Process result - coordinator handles the rest
                    switch result {
                    case .success:
                        coordinator.complete(success: true)
                    case .failure(let error):
                        coordinator.complete(success: false,
                                            error: error.livenessError.localizedDescription)
                    }

                    // Reset result state for next attempt
                    self.result = nil

                    // Wait for CoreLib to process and start countdown before accepting new tokens
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    isProcessingResult = false
                }
            }
        } else {
            Color.clear
                .onAppear {
                    // Token is nil - dismiss immediately
                    shouldPresent = false
                }
        }
    }
}

/// View extension for easy integration
extension View {
    /// Add Azure Liveness support to your view. Call this once with the coordinator.
    func msLiveness(coordinator: MSLivenessCoordinator?) -> some View {
        ZStack {
            self
            if let coordinator = coordinator {
                MSLivenessSwiftUIHelper(coordinator: coordinator)
            }
        }
    }
}
