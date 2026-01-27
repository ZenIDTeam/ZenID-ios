//
//  InvestigatingViewModel.swift
//  ZenID Sample
//
//  Base ViewModel using SDK's GenericVerifierViewModel with investigation flow
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID
import Combine

/// Base class for all iOS-Sample verifiers
/// Extends SDK's GenericVerifierViewModel and adds investigation step
@MainActor
class InvestigatingViewModel<V: VerifierProtocol>: GenericVerifierViewModel<V> {

    // MARK: - App State (for SampleViewModel protocol)

    var publishedState: Published<ScanningState>.Publisher { $scanningState }

    var stateCancellable: AnyCancellable?

    @Published var scanningState: ScanningState = .setup

    // MARK: - Alert State

    /// Alert to be shown to user (title, message)
    /// When this is set, the View shows a modal and navigation happens on dismiss
    @Published var errorAlert: (title: String, message: String)?

    // MARK: - Investigation Response

    /// Investigation response from the server
    @Published var investigationResponse: InvestigateSamplesResponse?

    // MARK: - Initialization

    override init() {
        super.init()

        // Map SDK VerificationState to app's ScanningState
        $state.sink { [weak self] sdkState in
            guard let self = self else { return }
            OSLogger.app.debug("InvestigatingViewModel: SDK state changed to: \(String(describing: sdkState))")
            switch sdkState {
            case .setup:
                self.scanningState = .setup
            case .scanning:
                self.scanningState = .scanning
            case .processing:
                self.scanningState = .processing
            case .uploading:
                self.scanningState = .uploading
            case .investigating:
                self.scanningState = .investigating
            case .success:
                if let response = self.investigationResponse {
                    self.scanningState = .done(response)
                } else {
                    self.scanningState = .error
                }
            case .error:
                OSLogger.app.error("InvestigatingViewModel: Setting scanningState to .error")
                self.scanningState = .error
            @unknown default:
                self.scanningState = .error
            }
            OSLogger.app.debug("InvestigatingViewModel: scanningState is now: \(String(describing: self.scanningState))")
        }.store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Callback Setup

    /// Override to add custom error handlers
    override func setupVerifierCallbacks() {
        super.setupVerifierCallbacks()

        verifier?.onFatalError = { [weak self] error in
            guard let self = self else { return }
            OSLogger.app.error("Fatal error: \(error.title) - \(error.message)")

            // Set alert state - View will show modal
            // Don't set .error state yet - alert dismiss handler will do it
            self.errorAlert = (title: error.title, message: error.message)
        }
    }

    // MARK: - Override uploadData to add investigation

    override func uploadData(_ data: Data) {
        // Set SDK state via super
        super.state = .uploading

        Task { @MainActor in
            do {
                OSLogger.app.info("Start uploading")

                let sampleData = try await ZenIDManager.uploadSample(data)
                let sample = try ZenIDManager.decode(sampleData, as: UploadSampleResponse.self)

                OSLogger.app.info("Start investigating")
                super.state = .investigating

                let sampleIds = [sample.sampleID].compactMap { $0 }
                let investigationData = try await ZenIDManager.investigateSamples(sampleIds: sampleIds)
                let investigation = try ZenIDManager.decode(investigationData, as: InvestigateSamplesResponse.self)

                OSLogger.app.info("Done!")
                self.investigationResponse = investigation
                super.state = .success
            } catch {
                OSLogger.app.error("Upload sample problem: \(error.localizedDescription)")
                super.state = .error(.uploadFailed(error.localizedDescription))
            }
        }
    }

    // MARK: - Setup and Start

    /// Setup method for authorization and configuration
    /// Subclasses override this to add custom setup
    func setup() async {
        // Override in subclasses
    }

    /// Override cleanup to properly call superclass cleanup
    /// This fixes the issue where protocol extension's cleanup() was shadowing the superclass method
    override func cleanup() {
        OSLogger.app.debug("InvestigatingViewModel.cleanup() called")
        stateCancellable?.cancel()
        cancellables.removeAll()  // Cancel all subscriptions stored in the set
        super.cleanup()  // Call GenericVerifierViewModel.cleanup() which does proper unload
    }

    deinit {
        // Cannot call cleanup() directly from deinit (MainActor isolated)
        // Cleanup should be called from .onDisappear in the UI
    }
}

// MARK: - SampleViewModel Conformance
extension InvestigatingViewModel: SampleViewModel {
    /// Protocol witness for SampleViewModel.sampleVerifier
    var sampleVerifier: AnyVerifier? {
        verifier as? AnyVerifier
    }

    /// scanningState is already declared in the class body, satisfies protocol requirement

    /// Start the verifier with camera view
    /// Call this after setup() from UI code
    func startVerifier(with cameraView: UIZenIDView) {
        start(with: cameraView)
    }
}
