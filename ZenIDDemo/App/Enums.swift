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
    case selfie = "Selfie"
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
        case .selfie:
            return .selfie
        }
    }
}

public enum DocumentType: String {
    case idCard = "Idc"
    case drivingLicence = "Drv"
    case passport = "Pas"
    case otherDocument = "Cont"
    case hologram = "Holo"
    case face = "Face"
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
            case .otherDocument:
                return "btn-other-document".localized.uppercased()
            case .hologram:
                return "btn-hologram".localized.uppercased()
            case .face:
                return "btn-face".localized.uppercased()
            }
        }
    }
    
    var scanRequests: [PhotoType] {
        get {
            switch self {
            case .idCard:
                return [.front, .back]
            case .drivingLicence:
                return [.front]
            case .passport:
                return [.front]
            case .otherDocument:
                return (0...30).map { _ in .front }
            case .hologram:
                return [.front]
            case .face:
                return [.selfie]
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
            case .otherDocument:
                return #imageLiteral(resourceName: "OK button@2x.png")
            case .hologram:
                return #imageLiteral(resourceName: "Kruh-HL")
            case .face:
                return #imageLiteral(resourceName: "Kruh-SF")
            }
        }
    }
}

public enum PhotoType {
    case front
    case back
    case selfie
}

extension PhotoType {
    var pageCode: String {
        get {
            switch(self) {
            case .front:
                return "F"
            case .back:
                return "B"
            case .selfie:
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
            case .selfie:
                return "msg-scan-selfie".localized
            }
        }
    }
}

public enum Country: String {
    case cz = "Cz"
    case sk = "Sk"
}
