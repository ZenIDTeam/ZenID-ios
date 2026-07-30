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

/// Helper class that manages MS Liveness Azure UI presentation in UIKit.
///
/// Owns:
/// - A black background to hide the dead camera view (Azure manages its own camera).
/// - Observation of `coordinator.presentation` — each new request is treated as a distinct
///   presentation, so retries cleanly tear down and re-host without timing hacks.
/// - The Azure `FaceLivenessDetectorView` hosting controller and its lifecycle.
///
/// Usage:
/// ```swift
/// // Create the coordinator once (e.g. on the view controller / presenter):
/// let coordinator = MSLivenessCoordinator()
/// // Wire the same coordinator into the verifier:
/// let verifier = try ZenIDManager.msLivenessVerifier(coordinator: coordinator)
///
/// // In viewDidAppear:
/// msLivenessHelper = MSLivenessUIKitHelper.setup(viewController: self, coordinator: coordinator)
/// try verifier.start()
/// ```
@MainActor
public class MSLivenessUIKitHelper {
    private let parentViewController: UIViewController
    private let zenIDView: UIZenIDView
    private let coordinator: MSLivenessCoordinator
    private var cancellables = Set<AnyCancellable>()
    private var azureHost: UIHostingController<AnyView>?
    private var presentedRequestID: UUID?
    private var blackBackgroundView: UIView?

    /// Setup the helper.
    /// - Parameters:
    ///   - viewController: The view controller that will host the Azure UI.
    ///   - coordinator: The coordinator wired into the MSLivenessVerifier.
    /// - Returns: Helper instance (store it to keep it alive, call `cleanup()` in
    ///   `viewWillDisappear`).
    public static func setup(viewController: UIViewController, coordinator: MSLivenessCoordinator) -> MSLivenessUIKitHelper? {
        guard let zenIDView = ZenIDManager.zenIDView as? UIZenIDView else {
            return nil
        }

        let helper = MSLivenessUIKitHelper(
            parentViewController: viewController,
            zenIDView: zenIDView,
            coordinator: coordinator
        )
        helper.start()
        return helper
    }

    init(parentViewController: UIViewController, zenIDView: UIZenIDView, coordinator: MSLivenessCoordinator) {
        self.parentViewController = parentViewController
        self.zenIDView = zenIDView
        self.coordinator = coordinator
    }

    /// Start observing the coordinator for Azure UI presentation requests.
    func start() {
        addBlackBackground()

        // React to each presentation request by `id` — a new id means a fresh Azure session
        // (initial run or retry), so we tear down any existing host and re-present.
        coordinator.$presentation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] request in
                guard let self else { return }
                if let request {
                    if request.id != self.presentedRequestID {
                        self.presentedRequestID = request.id
                        self.showAzureUI(token: request.token)
                    }
                } else {
                    self.presentedRequestID = nil
                    self.hideAzureUI()
                }
            }
            .store(in: &cancellables)
    }

    /// Clean up resources.
    public func cleanup() {
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
        // Tear down any existing Azure host before re-presenting (handles retries cleanly).
        hideAzureUI()

        var livenessResult: LivenessDetectionResult?
        let binding = Binding<LivenessDetectionResult?>(
            get: { livenessResult },
            set: { [weak self] newValue in
                livenessResult = newValue
                if let result = newValue {
                    self?.handleLivenessResult(result)
                }
            }
        )

        let azureView = FaceLivenessDetectorView(
            result: binding,
            sessionAuthorizationToken: token
        )

        let host = UIHostingController(rootView: AnyView(azureView))
        azureHost = host

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

        // Cover the ZenID view while Azure is in front.
        parentViewController.view.bringSubviewToFront(host.view)
    }

    private func hideAzureUI() {
        guard let host = azureHost else { return }

        // Bring ZenID view to front so the visualizer shows the retry countdown.
        parentViewController.view.bringSubviewToFront(zenIDView)

        host.willMove(toParent: nil)
        host.view.removeFromSuperview()
        host.removeFromParent()
        azureHost = nil
    }

    private func handleLivenessResult(_ result: LivenessDetectionResult) {
        switch result {
        case .success:
            coordinator.complete(success: true, error: nil)
        case .failure(let error):
            coordinator.complete(success: false, error: MSLivenessErrorName.name(forRawValue: error.livenessError.rawValue))
            // SDK republishes a new presentation request (with a fresh id) for the retry.
        }
    }
}
