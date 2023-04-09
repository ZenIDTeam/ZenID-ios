//
//  UserDefaultsNfcState.swift
//  ZenIDDemo
//
//  Created by Lukas Gergel on 09.04.2023.
//  Copyright © 2023 Trask, a.s. All rights reserved.
//

import Foundation

final class UserDefaultsNfcState {
}

extension UserDefaultsNfcState: NfcStateLoader {
    func load() throws -> Bool {
        Defaults.isNfcEnabled
    }
}

extension UserDefaultsNfcState: NfcStateSaver {
    func save(isEnabled: Bool, completion: (NfcStateSaver.Result) -> Void) {
        Defaults.isNfcEnabled = isEnabled
        completion(.success(()))
    }
}
