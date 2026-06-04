//
//  MSLivenessViewModel.swift
//  ZenID SDK
//
//  This is a REFERENCE FILE showing the SDK implementation.
//  The actual MSLivenessViewModel is included in the ZenID SDK.
//
//  You don't need to copy this file - just use:
//  `let viewModel = MSLivenessViewModel()`
//
//  Copyright © 2024 Trask, a.s. All rights reserved.
//

import Foundation
import ZenID
import Combine

// REFERENCE SOURCE CODE - This code is already compiled into SDK
// Use MSLivenessViewModel directly without copying this file!

/// MSLivenessVerifier ViewModel
///
/// This ViewModel manages MS Liveness verification. Unlike other verifiers, MS Liveness needs
/// the host app to present Azure's `FaceLivenessDetectorView`. The bridge is the
/// ``MSLivenessCoordinator`` exposed below.
///
/// The coordinator is owned by the view model (created eagerly in `init`) and wired into the
/// verifier when it is created. SwiftUI views can therefore observe it from body-build time
/// without depending on the verifier's lifecycle.
///
/// **SwiftUI Integration:**
/// ```swift
/// struct MyView: View {
///     @StateObject var viewModel = MSLivenessViewModel()
///
///     var body: some View {
///         ZStack {
///             Color.black.ignoresSafeArea()
///             ZenIDView()
///         }
///         .onAppear {
///             if let view = ZenIDManager.zenIDView { viewModel.start(with: view) }
///         }
///         .onDisappear { viewModel.cleanup() }
///         .msLiveness(coordinator: viewModel.coordinator)   // never nil
///     }
/// }
/// ```
///
/// **UIKit Integration:**
/// ```swift
/// class MyViewController: UIViewController {
///     let viewModel = MSLivenessViewModel()
///     var msLivenessHelper: MSLivenessUIKitHelper?
///
///     override func viewDidAppear(_ animated: Bool) {
///         super.viewDidAppear(animated)
///         viewModel.start(with: cameraView)
///         msLivenessHelper = MSLivenessUIKitHelper.setup(
///             viewController: self,
///             coordinator: viewModel.coordinator
///         )
///     }
/// }
/// ```
@MainActor
public final class MSLivenessViewModel: GenericVerifierViewModel<MSLivenessVerifier> {
    private let settings: MsLivenessVerifierSettings

    /// Coordinator that bridges Azure UI presentation with the verification loop. Always
    /// non-nil; observe ``MSLivenessCoordinator/presentation`` to drive Azure UI.
    public let coordinator: MSLivenessCoordinator

    public init(settings: MsLivenessVerifierSettings = .init(),
                coordinator: MSLivenessCoordinator = MSLivenessCoordinator()) {
        self.settings = settings
        self.coordinator = coordinator
        super.init()
    }

    public override func createVerifier() throws -> MSLivenessVerifier {
        try ZenIDManager.msLivenessVerifier(settings: settings, coordinator: coordinator)
    }
}
