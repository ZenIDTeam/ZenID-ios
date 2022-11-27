//
//  ResultsViewModel.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 01/02/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Common
import UIKit

enum InvestigateDataRow {
    case firstName
    case lastName
    case birthDate
    case documentNumber
    case issueDate
    case expiryDate
    case nationality
    case address
    case authority
    case selfie
    case hologram

    var title: String {
        var msg: String
        switch self {
        case .firstName:
            msg = "title-first-name"
        case .lastName:
            msg = "title-last-name"
        case .birthDate:
            msg = "title-birth-date"
        case .documentNumber:
            msg = "title-document-number"
        case .issueDate:
            msg = "title-issue-date"
        case .expiryDate:
            msg = "title-expiry-date"
        case .nationality:
            msg = "title-nationality"
        case .address:
            msg = "title-address"
        case .authority:
            msg = "title-authority"
        case .selfie:
            msg = "title-selfie"
        case .hologram:
            msg = "title-hologram"
        }
        return msg.localized
    }
}

extension InvestigateDataRow {
    func value(from: InvestigateResponse) -> String {
        if self == .selfie || self == .hologram {
            return "msg-sample-success".localized
        }

        guard let data = from.MinedData else { return "" }
        var result: String?

        switch self {
        case .firstName:
            result = data.FirstName?.Text
        case .lastName:
            result = data.LastName?.Text
        case .birthDate:
            result = data.BirthDate?.Text
        case .documentNumber:
            result = getDocumentNumber(from: from)
        case .issueDate:
            result = data.IssueDate?.Text
        case .expiryDate:
            result = data.ExpiryDate?.Text
        case .nationality:
            result = data.Nationality?.Text
        case .address:
            result = data.Address?.Text
        case .authority:
            result = data.Authority?.Text
        default:
            result = ""
        }

        return result ?? ""
    }

    func confidence(from: InvestigateResponse) -> Bool? {
        if self == .selfie || self == .hologram {
            return true
        }

        guard let data = from.MinedData else { return nil }
        var result: Bool?

        switch self {
        case .firstName:
            result = data.FirstName?.Confidence == 100
        case .lastName:
            result = data.LastName?.Confidence == 100
        case .birthDate:
            result = data.BirthDate?.Confidence == 100
        case .documentNumber:
            result = getDocumentNumberConfidence(from: from) == 100
        case .issueDate:
            result = data.IssueDate?.Confidence == 100
        case .expiryDate:
            result = data.ExpiryDate?.Confidence == 100
        case .nationality:
            result = data.Nationality?.Confidence == 100
        case .address:
            result = data.Address?.Confidence == 100
        case .authority:
            result = data.Authority?.Confidence == 100
        default:
            result = false
        }
        return result
    }

    private func getDocumentNumber(from: InvestigateResponse) -> String? {
        guard let documentCode = from.MinedData?.documentCode else { return nil }
        switch documentCode.documentType {
        case .idCard:
            return from.MinedData?.IdcardNumber?.Text
        case .drivingLicence:
            return from.MinedData?.DrivinglicenseNumber?.Text
        case .passport:
            return from.MinedData?.PassportNumber?.Text
        default:
            return "Test"
        }
    }

    private func getDocumentNumberConfidence(from: InvestigateResponse) -> Int? {
        guard let documentCode = from.MinedData?.documentCode else { return nil }
        switch documentCode.documentType {
        case .idCard:
            return from.MinedData?.IdcardNumber?.Confidence
        case .drivingLicence:
            return from.MinedData?.DrivinglicenseNumber?.Confidence
        case .passport:
            return from.MinedData?.PassportNumber?.Confidence
        default:
            return 1
        }
    }
}

struct InvestigateDataItem {
    var row: InvestigateDataRow
    var value: String
    var editable: Bool
}

class ResultsViewModel {
    let documentType: DocumentType
    let investigateResponse: InvestigateResponse

    var allRows: [InvestigateDataRow] {
        switch documentType {
        case .idCard:
            return [.firstName, .lastName, .birthDate, .documentNumber, .issueDate, .expiryDate, .nationality, .address, .authority]
        case .drivingLicence:
            return [.firstName, .lastName, .birthDate, .documentNumber, .issueDate, .expiryDate, .address, .authority]
        case .passport:
            return [.firstName, .lastName, .birthDate, .documentNumber, .issueDate, .expiryDate, .nationality, .address, .authority]
        case .face:
            return [.selfie]
        case .documentVideo:
            return [.hologram]
        default:
            return []
        }
    }

    var values: [InvestigateDataItem] {
        return allRows.map {
            return InvestigateDataItem(
                row: $0,
                value: $0.value(from: investigateResponse),
                editable: !($0.confidence(from: investigateResponse) ?? false)
            )
        }
    }

    var ministryCheck: Bool? {
        return validation(code: .ministry)
    }

    var insolvencyCheck: Bool? {
        // TODO: This is not implemented on backend yet
        return nil
    }

    var selfieCheck: Bool? {
        return validation(code: .selfie)
    }

    init(documentType: DocumentType, investigateResponse: InvestigateResponse) {
        self.investigateResponse = investigateResponse
        self.documentType = documentType
    }

    func validation(code: ValidatorCodes) -> Bool? {
        guard let results = investigateResponse.ValidatorResults else { return nil }

        for valResp in results {
            if let valCode = valResp.Code {
                if code.rawValue == valCode {
                    return valResp.Ok
                }
            }
        }
        return nil
    }
}
