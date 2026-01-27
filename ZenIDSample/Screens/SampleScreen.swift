//
//  SampleScreen.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI
import ZenID
import AzureAIVisionFaceUI
import Combine

struct SampleScreen<ViewModel>: View, IdentifiableScreen where ViewModel: SampleViewModel & ObservableObject {

    @EnvironmentObject var navigationManager: NavigationManager

    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel: ViewModel

    @State var state: ScanningState = .scanning


    var body: some View {
        mainContent
            .onAppear {
                OSLogger.app.debug("SampleScreen.onAppear called")
                Task { @MainActor in
                    await viewModel.setup()
                }
            }
            .onDisappear {
                OSLogger.app.debug("SampleScreen.onDisappear called")
                viewModel.cleanup()
            }
            .msLiveness(coordinator: (viewModel as? MsLivenessViewModel)?.coordinator)
            .onReceive(viewModel.publishedState, perform: handleStateChange)
            .alert(
                viewModel.errorAlert?.title ?? "",
                isPresented: errorAlertBinding
            ) {
                Button("general-Ok".localized, role: .cancel) { }
            } message: {
                Text(viewModel.errorAlert?.message ?? "")
            }
    }

    private var mainContent: some View {
        ZStack {
            if viewModel is MsLivenessViewModel {
                // MS Liveness: Always show black background to hide camera (Azure handles camera)
                // ZenIDView still needed for visualizer messages during retry
                Color.black.edgesIgnoringSafeArea(.all)
                ZenIDView()
            } else {
                // Other verifiers: Show camera + visualizer normally
                ZenIDView()
            }
            switch state {
            case .processing:
                WaitView(title: "Processing...", icon: "gear.badge.checkmark", rotate: true)
            case .uploading:
                WaitView(title: "Uploading...", icon: "icloud.and.arrow.up", rotate: false)
            case .investigating:
                WaitView(title: "Investigating...", icon: "mail.and.text.magnifyingglass", rotate: false)
            case .done(_):
                WaitView(title: "Done!", icon: "checkmark.circle", rotate: false)
            default: Spacer()
            }

            // NFC retry button overlay
            if let documentViewModel = viewModel as? DocumentViewModel, documentViewModel.showNfcRetryButton {
                VStack {
                    Spacer()
                    VStack(spacing: 16) {
                        Text("NFC reading failed")
                            .font(.headline)
                        Text("Please try again or cancel the verification")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                        HStack(spacing: 16) {
                            Button(action: {
                                documentViewModel.cancelNfc()
                            }) {
                                Text("Cancel")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)

                            Button(action: {
                                documentViewModel.retryNfc()
                            }) {
                                Text("Retry")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding()
                }
            }
        }
    }

    private var errorAlertBinding: Binding<Bool> {
        Binding(
            get: { viewModel.errorAlert != nil },
            set: { isPresented in
                if !isPresented {
                    // User dismissed alert - clear it and set error state
                    let message = viewModel.errorAlert?.message ?? "Verification failed"
                    viewModel.errorAlert = nil
                    // Set error state - onReceive will handle navigation reactively
                    viewModel.state = .error(.verifierFailed(message))
                }
            }
        )
    }

    private func handleStateChange(_ value: ScanningState) {
        withAnimation {
            state = value
        }
        switch value {
        case .done(let investigateResult):
            navigationManager.navigate(to: Screen.result(investigateResult))
        case .error:
            OSLogger.app.error("SampleScreen: Error state received, navigating back")
            navigationManager.pop()
        default: break
        }
    }
}
