//
//  DispatchError.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 20/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation

enum DispatchError: Error {
    case unreadablePicture
    case unknownEstimatedDocumentType
    case documentTypesDontMatch
    case incorrectlyRecognizedAsFront
    case incorrectlyRecognizedAsBack
    case incorrectlyRecognizedAsSelfie
    case networkError
}

extension DispatchError {
    var message: String {
        get {
            switch self {
            case .unreadablePicture:
                return "msg-unreadable-picture".localized
            case .unknownEstimatedDocumentType:
                return "msg-unknown-estimated-document-type".localized
            case .documentTypesDontMatch:
                return "msg-document-types-dont-match".localized
            case .incorrectlyRecognizedAsFront:
                return "msg-incorrectly-recognized-as-front".localized
            case .incorrectlyRecognizedAsBack:
                return "msg-incorrectly-recognized-as-back".localized
            case .incorrectlyRecognizedAsSelfie:
                return "msg-incorrectly-recognized-as-selfie".localized
            case .networkError:
                return "msg-network-error".localized
            }
        }
    }
}
