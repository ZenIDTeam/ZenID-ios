//
//  MSLivenessUIKitHelper.swift
//  ZenID Demo
//
//  Helper class that manages MS Liveness Azure UI presentation for UIKit.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import UIKit
import SwiftUI
import ZenID
import Combine
import AzureAIVisionFaceUI

/// Protocol for view models that provide MS Liveness coordinator access
protocol MSLivenessCoordinatorProvider: AnyObject {
    var coordinator: MSLivenessCoordinator? { get }
}

/// Make SDK's MSLivenessViewModel conform to the protocol
extension ZenID.MSLivenessViewModel: MSLivenessCoordinatorProvider {}

/// Helper class that manages MS Liveness Azure UI presentation in UIKit.
///
/// This class handles:
/// - Adding black background to hide camera
/// - Observing coordinator token changes
/// - Presenting/dismissing Azure UI as a child view controller
/// - Handling Azure liveness results
/// - Managing retry logic
///
/// Usage (in viewDidAppear):
/// ```swift
/// // Setup helper (adds black background and polls for coordinator)
/// msLivenessHelper = MSLivenessUIKitHelper.setup(
///     viewController: self,
///     coordinatorProvider: viewModel
/// )
///
/// // Start the verifier
/// viewModel.start(with: cameraView)
/// ```
@MainActor
class MSLivenessUIKitHelper {
    private let parentViewController: UIViewController
    private let zenIDView: UIZenIDView
    private weak var coordinatorProvider: MSLivenessCoordinatorProvider?
    private var cancellables = Set<AnyCancellable>()
    private var azureHost: UIHostingController<AnyView>?
    private var livenessResult: LivenessDetectionResult?
    private var blackBackgroundView: UIView?
    private var isProcessingResult = false
    private var coordinator: MSLivenessCoordinator?
    private var coordinatorCheckTimer: Timer?

    /// Simple setup method - just pass your view controller and coordinator provider
    /// - Parameters:
    ///   - viewController: The view controller that will host the Azure UI
    ///   - coordinatorProvider: Object that provides access to MSLivenessCoordinator (typically MSLivenessViewModel)
    /// - Returns: Helper instance (store it to keep it alive, call cleanup() in viewWillDisappear)
    static func setup(viewController: UIViewController, coordinatorProvider: MSLivenessCoordinatorProvider) -> MSLivenessUIKitHelper? {
        guard let zenIDView = ZenIDManager.zenIDView as? UIZenIDView else {
            return nil
        }

        let helper = MSLivenessUIKitHelper(
            parentViewController: viewController,
            zenIDView: zenIDView,
            coordinatorProvider: coordinatorProvider
        )
        helper.start()
        return helper
    }

    /// Initialize the helper
    /// - Parameters:
    ///   - parentViewController: The view controller that will host the Azure UI
    ///   - zenIDView: The UIZenIDView for camera rendering
    ///   - coordinatorProvider: Object that provides access to MSLivenessCoordinator
    init(parentViewController: UIViewController, zenIDView: UIZenIDView, coordinatorProvider: MSLivenessCoordinatorProvider) {
        self.parentViewController = parentViewController
        self.zenIDView = zenIDView
        self.coordinatorProvider = coordinatorProvider
    }

    /// Start observing coordinator token for Azure UI presentation
    func start() {
        // Add black background to hide camera (Azure handles camera)
        addBlackBackground()

        // Check for coordinator immediately
        checkForCoordinator()

        // If not found, set up timer to poll for it
        if coordinator == nil {
            coordinatorCheckTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                self?.checkForCoordinator()
            }
        }
    }

    private func checkForCoordinator() {
        guard coordinator == nil else { return }

        if let coordinator = coordinatorProvider?.coordinator {
            coordinatorCheckTimer?.invalidate()
            coordinatorCheckTimer = nil
            self.coordinator = coordinator
            observeCoordinatorToken(coordinator)
        }
    }

    private func observeCoordinatorToken(_ coordinator: MSLivenessCoordinator) {
        // Check if token already exists and show UI immediately
        if let token = coordinator.token {
            showAzureUI(token: token)
        }

        // Observe coordinator token for Azure UI presentation
        coordinator.$token
            .receive(on: DispatchQueue.main)
            .sink { [weak self] token in
                guard let self = self, !self.isProcessingResult else { return }
                if let token = token {
                    self.showAzureUI(token: token)
                } else {
                    self.hideAzureUI()
                }
            }
            .store(in: &cancellables)
    }

    /// Clean up resources
    func cleanup() {
        coordinatorCheckTimer?.invalidate()
        coordinatorCheckTimer = nil
        hideAzureUI()
        removeBlackBackground()
        cancellables.removeAll()
    }

    // MARK: - Private Methods

    private func addBlackBackground() {
        let blackView = UIView()
        blackView.backgroundColor = .black
        blackView.translatesAutoresizingMaskIntoConstraints = false
        parentViewController.view.insertSubview(blackView, at: 0)
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: parentViewController.view.topAnchor),
            blackView.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor),
            blackView.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor)
        ])
        blackBackgroundView = blackView
    }

    private func removeBlackBackground() {
        blackBackgroundView?.removeFromSuperview()
        blackBackgroundView = nil
    }

    private func showAzureUI(token: String) {
        // Clean up existing host if present (for retries)
        if let existingHost = azureHost {
            existingHost.willMove(toParent: nil)
            existingHost.view.removeFromSuperview()
            existingHost.removeFromParent()
            azureHost = nil
        }

        livenessResult = nil

        // Create binding for Azure result
        let binding = Binding(
            get: { [weak self] in self?.livenessResult },
            set: { [weak self] newValue in
                self?.livenessResult = newValue
                if let result = newValue {
                    self?.handleLivenessResult(result)
                }
            }
        )

        // Create Azure UI
        let azureView = FaceLivenessDetectorView(
            result: binding,
            sessionAuthorizationToken: token
        )
        .environment(\.locale, Locale(identifier: ZenIDManager.getLanguageLocale()))

        let host = UIHostingController(rootView: AnyView(azureView))
        azureHost = host

        // Add as child view controller
        parentViewController.addChild(host)
        parentViewController.view.addSubview(host.view)
        host.didMove(toParent: parentViewController)

        host.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: parentViewController.view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor)
        ])

        // Bring to front to cover ZenID view
        parentViewController.view.bringSubviewToFront(host.view)
    }

    private func hideAzureUI() {
        guard let host = azureHost else { return }

        // Bring ZenID view to front to show CoreLib rendering
        parentViewController.view.bringSubviewToFront(zenIDView)

        // Remove Azure hosting controller
        host.willMove(toParent: nil)
        host.view.removeFromSuperview()
        host.removeFromParent()
        azureHost = nil
    }

    private func handleLivenessResult(_ result: LivenessDetectionResult) {
        Task { @MainActor in
            guard let coordinator = self.coordinator else { return }

            // Temporarily block token updates to prevent brief reappearance
            isProcessingResult = true

            // Clear token and hide Azure UI immediately
            coordinator.token = nil
            hideAzureUI()

            // Give UI a moment to actually dismiss and show visualizer
            try? await Task.sleep(nanoseconds: 100_000_000) // 100ms

            // Submit result to coordinator
            switch result {
            case .success:
                coordinator.complete(success: true, error: nil)
            case .failure(let error):
                coordinator.complete(success: false, error: error.localizedDescription)
                // SDK will handle retry automatically by providing a new token
            }

            // Reset result state for next attempt
            livenessResult = nil

            // Wait for CoreLib to process and start countdown before accepting new tokens
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
            isProcessingResult = false
        }
    }
}
