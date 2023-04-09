//
//  NfcStateLoaderComposer.swift
//  ZenIDDemo
//
//  Created by Lukas Gergel on 09.04.2023.
//  Copyright © 2023 Trask, a.s. All rights reserved.
//

import Foundation

final class NfcStateLoaderComposer {
    private static var service: (NfcStateLoader & NfcStateSaver)?

    static func compose() -> NfcStateLoader & NfcStateSaver {
        if service == nil {
            service = UserDefaultsNfcState()
        }
        return service!
    }
}
