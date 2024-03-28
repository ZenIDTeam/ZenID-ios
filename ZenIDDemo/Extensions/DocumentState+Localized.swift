//
//  DocumentState+Localized.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 01/07/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

extension UnifiedState {
    var localizedDescription: String {
        switch self {
        case .ok:
            return LocalizedString("document-State-Ok")
        case .alignCard:
            return LocalizedString("document-State-AlignCard")
        case .blurry:
            return LocalizedString("document-State-Blurry")
        case .holdSteady:
            return LocalizedString("document-State-HoldSteady")
        case .notFound:
            return LocalizedString("document-State-NoMatchFound")
        case .reflectionPresent:
            return LocalizedString("document-State-ReflectionPresent")
        case .hologram:
            return LocalizedString("document-State-HologramError")
        case .dark:
            return LocalizedString("document-State-Dark")
        case .barcode:
            return LocalizedString("document-State-Barcode")
        case .timedOut:
            return LocalizedString("document-State-Timedout")
        default:
            return String(describing: self)
        }
    }
}
