//
//  DocumentState+Localized.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 01/07/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

extension RecogLib_iOS.DocumentState {
    var localizedDescription: String {
        switch self {
        case .Ok:
            return "document.state.ok".localized
        case .AlignCard:
            return "document.state.align.card".localized
        case .Blurry:
            return "document.state.blurry".localized
        case .HoldSteady:
            return "document.state.hold.steady".localized
        case .NoMatchFound:
            return "document.state.no.match.found".localized
        case .ReflectionPresent:
            return "document.state.reflection.present".localized
        case .Hologram:
            return "document.state.hologram.error".localized
        case .Dark:
            return "document.state.dark".localized
        case .Barcode:
            return "document.state.barcode".localized
        }
    }
}

extension UnifiedState {
    var localizedDescription: String {
        switch self {
        case .ok:
            return "document.state.ok".localized
        case .alignCard:
            return "document.state.align.card".localized
        case .blurry:
            return "document.state.blurry".localized
        case .holdSteady:
            return "document.state.hold.steady".localized
        case .notFound:
            return "document.state.no.match.found".localized
        case .reflectionPresent:
            return "document.state.reflection.present".localized
        case .hologram:
            return "document.state.hologram.error".localized
        case .dark:
            return "document.state.dark".localized
        case .barcode:
            return "document.state.barcode".localized
        default:
            return String(describing: self)
        }
    }
}
