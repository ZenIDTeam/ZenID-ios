//
//  SampleViewModel.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation
import ZenID
import Combine

protocol AnyVerifier: AnyObject {
    func stopAsync()
}

extension BaseVerifier: AnyVerifier {
    nonisolated public func stopAsync() {
        Task { @MainActor in
            self.stop()
        }
    }
}

@MainActor
protocol SampleViewModel: AnyObject, ObservableObject {

    var publishedState: Published<ScanningState>.Publisher { get }

    var stateCancellable: AnyCancellable? { get set }

    var sampleVerifier: AnyVerifier? { get }

    var scanningState: ScanningState { get set }

    var errorAlert: (title: String, message: String)? { get set }

    var state: VerificationState { get set }

    func setup() async

    func cleanup()

}

enum ScanningState: Equatable {
    case setup
    case scanning
    case processing
    case uploading
    case investigating
    case done(_ investigateResponse: InvestigateSamplesResponse)
    case error
}
