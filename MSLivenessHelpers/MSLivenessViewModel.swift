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
/// This ViewModel manages MS Liveness verification. Unlike other verifiers,
/// MS Liveness requires additional Azure UI integration via the coordinator.
///
/// **SwiftUI Integration:**
/// ```swift
/// struct MyView: View {
///     @StateObject var viewModel = MSLivenessViewModel()
///
///     var body: some View {
///         ZStack {
///             Color.black.edgesIgnoringSafeArea(.all)
///             ZenIDView()
///         }
///         .onAppear { viewModel.start(with: ZenIDManager.zenIDView) }
///         .onDisappear { viewModel.cleanup() }
///         .msLiveness(coordinator: viewModel.coordinator)
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

    /// The MS Liveness coordinator for Azure UI integration
    /// Pass this to `.msLiveness()` modifier (SwiftUI) or `MSLivenessUIKitHelper.setup()` (UIKit)
    public var coordinator: MSLivenessCoordinator? {
        verifier?.coordinator
    }

    public init(settings: MsLivenessVerifierSettings = .init()) {
        self.settings = settings
        super.init()
    }

    public override func createVerifier() throws -> MSLivenessVerifier {
        try ZenIDManager.msLivenessVerifier(settings: settings)
    }
}
