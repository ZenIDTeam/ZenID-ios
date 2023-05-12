//
//  Enums.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import RecogLib_iOS
import UIKit

public enum UploadedSampleType: String {
    case documentPicture = "DocumentPicture"
    case documentVideo = "DocumentVideo"
    case faceVideo = "SelfieVideo"
    case facePicture = "Selfie"
    case otherDocument = "Archived"

    static func from(photoType: PhotoType, documentType: DocumentType, dataType: DataType) -> UploadedSampleType {
        if case .otherDocument = documentType {
            return .otherDocument
        }
        switch photoType {
        case .front, .back:
            if dataType == .video {
                return .documentVideo
            }
            return .documentPicture
        case .face:
            if dataType == .video {
                return .faceVideo
            }
            return .facePicture
        }
    }
}

public enum DocumentType: String {
    case idCard = "Idc"
    case drivingLicence = "Drv"
    case passport = "Pas"
    case unspecifiedDocument = "Unsp"
    case filter = "Filter"
    case otherDocument = "Cont"
    case face = "Self"
    case documentVideo = "DocVideo"
}

extension DocumentType {
    var title: String {
        switch self {
        case .idCard:
            return "btn-id".localized.uppercased()
        case .drivingLicence:
            return "btn-driving-licence".localized.uppercased()
        case .passport:
            return "btn-passport".localized.uppercased()
        case .unspecifiedDocument:
            return "btn-unspecified-document".localized.uppercased()
        case .otherDocument:
            return "btn-other-document".localized.uppercased()
        case .face:
            return "btn-face".localized.uppercased()
        case .filter:
            return NSLocalizedString("btn-filter", comment: "").uppercased()
        case .documentVideo:
            return NSLocalizedString("btn-hologram", comment: "").uppercased()
        }
    }

    var scanRequests: [PhotoType] {
        switch self {
        case .idCard:
            return [.front, .back, .face]
        case .drivingLicence:
            return [.front, .face]
        case .passport:
            return [.front, .face]
        case .unspecifiedDocument:
            return [.front, .face]
        case .otherDocument:
            return (0 ... 30).map { _ in .front }
        case .documentVideo:
            return [.front]
        case .face:
            return [.face]
        case .filter:
            return [.front]
        }
    }

    var backgoundImage: UIImage {
        switch self {
        case .idCard:
            return #imageLiteral(resourceName: "Kruh-OP")
        case .drivingLicence:
            return #imageLiteral(resourceName: "Kruh-RP")
        case .passport:
            return #imageLiteral(resourceName: "Kruh-CP")
        case .unspecifiedDocument:
            return #imageLiteral(resourceName: "OK button@2x.png")
        case .otherDocument:
            return #imageLiteral(resourceName: "OK button@2x.png")
        case .face:
            return #imageLiteral(resourceName: "Kruh-SF")
        default:
            return #imageLiteral(resourceName: "Kruh-SF")
        }
    }
}

public enum PhotoType {
    case front
    case back
    case face

    var isDocument: Bool {
        self == .front || self == .back
    }
}

extension PhotoType {
    var pageCode: String {
        switch self {
        case .front:
            return "F"
        case .back:
            return "B"
        case .face:
            return "F"
        }
    }
}

public enum FaceMode: String {
    case faceLiveness = "FaceLiveness"
    case selfie = "Selfie"

    init?(index: Int) {
        if index == 0 {
            self = .selfie
        } else if index == 1 {
            self = .faceLiveness
        } else {
            return nil
        }
    }
}
