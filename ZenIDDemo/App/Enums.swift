//
//  Enums.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

public enum UploadedSampleType: String {
    case documentPicture = "DocumentPicture"
    case documentVideo = "DocumentVideo"
    case face = "Selfie"
    case otherDocument = "Archived"
    
    static func from(photoType: PhotoType, documentType: DocumentType) -> UploadedSampleType {
        if case .otherDocument = documentType {
            return .otherDocument
        }
        switch photoType {
        case .front:
            if case .hologram = documentType {
                return .documentVideo
            } else {
                return .documentPicture
            }
        case .back:
            return .documentPicture
        case .face:
            return .face
        case .hologram:
            return .documentVideo
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
    case hologram = "Holo"
    case face = "Self"
}

extension DocumentType {
    var title: String {
        get {
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
            case .hologram:
                return "btn-hologram".localized.uppercased()
            case .face:
                return "btn-face".localized.uppercased()
            case .filter:
                return NSLocalizedString("btn-filter", comment: "").uppercased()
            }
        }
    }
    
    var scanRequests: [PhotoType] {
        get {
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
                return (0...30).map { _ in .front }
            case .hologram:
                return [.hologram]
            case .face:
                return [.face]
            case .filter:
                return [.front]
            }
        }
    }
    
    var backgoundImage: UIImage {
        get {
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
            case .hologram:
                return #imageLiteral(resourceName: "Kruh-HL")
            case .face:
                return #imageLiteral(resourceName: "Kruh-SF")
            default:
                return #imageLiteral(resourceName: "Kruh-SF")
            }
        }
    }
}

public enum PhotoType {
    case front
    case back
    case hologram
    case face
}

extension PhotoType {
    var pageCode: String {
        get {
            switch(self) {
            case .front:
                return "F"
            case .back:
                return "B"
            case .hologram:
                return "F"
            case .face:
                return "F"
            }
        }
    }
    
    var message: String {
        get {
            switch(self) {
            case .front:
                return "msg-scan-front".localized
            case .back:
                return "msg-scan-back".localized
            case .hologram:
                return "msg-scan-hologram".localized
            case .face:
                return "msg-scan-face".localized
            }
        }
    }
}

public enum Country: String {
    case cz = "Cz"
    case sk = "Sk"
    case at = "At"
    case hu = "Hu"
    case pl = "Pl"
    case de = "De"
    case hr = "Hr"
    case it = "It"
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

public enum ImageFlip: Int {
    case none
    case fromLandScape
    case fromPortrait
}
