//
//  ZenIDModels.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 13.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import Foundation

// This models were generated from Swagger.

enum ErrorCode: String, Codable {
    case unknownSampleID = "UnknownSampleID"
    case unknownUploadSessionID = "UnknownUploadSessionID"
    case emptyBody = "EmptyBody"
    case internalServerError = "InternalServerError"
    case invalidTimeStamp = "InvalidTimeStamp"
    case sampleInInvalidState = "SampleInInvalidState"
    case invalidSampleCombination = "InvalidSampleCombination"
    case accessDenied = "AccessDenied"
    case unknownPerson = "UnknownPerson"
    case invalidInputData = "InvalidInputData"
    case initSDKRecreatesSessionError = "InitSDKRecreatesSessionError"
    case invalidLegalEntity = "InvalidLegalEntity"
    case licenseExhausted = "LicenseExhausted"
    case investigationInInvalidState = "InvestigationInInvalidState"
}


// MARK: - InvestigationState
enum InvestigationState: String, Codable {
    case notDone = "NotDone"
    case done = "Done"
    case error = "Error"
    case operatorPending = "Operator"
    case rejected = "Rejected"
    case archived = "Archived"
}

// MARK: - RecogLib.RankDetail
struct RankDetail: Codable {
    var overall: OverallRank?
    var samples: [SampleOverview]?
    var conditions: [RankCondition]?
}

enum OverallRank: String, Codable {
    case a = "A"
    case b = "B"
    case f = "F"
}

// MARK: - RecogLib.SampleOverview
struct SampleOverview: Codable {
    var sampleType: SampleType?
    var page: PageCode?
    var rank: OverallRank?
    var documentCode: String?
    var sampleID: String?
}

enum PageCode: String, Codable {
    case front = "F"
    case back = "B"
}

// MARK: - RecogLib.RankCondition
struct RankCondition: Codable {
    var result: OverallRank?
    var conditionParamJson: String?
    var type: RankConditionType?
}

enum RankConditionType: String, Codable {
    case failedMrzAndNoBlurNoLowConfidence = "FailedMrzAndNoBlurNoLowConfidence"
    case failedMrzAndFontShape = "FailedMrzAndFontShape"
    case expirationAndFontShape = "ExpirationAndFontShape"
    case barcodeAndNoBlur = "BarcodeAndNoBlur"
    case barcodeAndMrzMismatch = "BarcodeAndMrzMismatch"
    case simple = "Simple"
    case fontFailedNoBlur = "FontFailedNoBlur"
}

// MARK: - ZenidWeb.InvestigationValidatorResponse
struct InvestigationValidatorResponse: Codable {
    var name: String?
    var code: Int?
    var score: Int?
    var acceptScore: Int?
    var issues: [InvestigationIssueResponse]?
    var ok: Bool?
}

// MARK: - ZenidWeb.InvestigationIssueResponse
struct InvestigationIssueResponse: Codable {
    var issueUrl: String?
    var issueDescription: String?
    var documentCode: String?
    var fieldID: String?
    var sampleID: String?
    var pageCode: PageCode?
    var sampleType: SampleType?
}

// MARK: - ZenidWeb.InvestigateResponse.EDokladyTransactionResult
struct EDokladyTransactionResult: Codable {
    var transactionID: String?
    var virtualCounterID: String?
    var virtualCounterName: String?
    var legalEntityName: String?
    var branchName: String?
    var branchOfficerIdentifier: String?
    var created: String?
    var lastChecked: String?
    var transactionState: EDokladyTransactionState?
    var resultState: EDokladyResultState?
    var operatorCanceled: Bool?
}

enum EDokladyTransactionState: String, Codable {
    case canceled = "CANCELED"
    case failed = "FAILED"
    case finished = "FINISHED"
    case open = "OPEN"
    case responseReceived = "RESPONSE_RECEIVED"
    case unfinished = "UNFINISHED"
    case waitingForResponse = "WAITING_FOR_RESPONSE"
    case timeout = "TIMEOUT"
}

enum EDokladyResultState: String, Codable {
    case success = "SUCCESS"
    case untrusted = "UNTRUSTED"
    case unknownError = "UNKNOWN_ERROR"
    case missingData = "MISSING_DATA"
    case expired = "EXPIRED"
}

enum Sex: String, Codable {
    case f = "F"
    case m = "M"
}

enum MaritalStatus: String, Codable {
    case single = "Single"
    case married = "Married"
    case divorced = "Divorced"
    case widowed = "Widowed"
    case partnership = "Partnership"
}

// MARK: - ZenidShared.LazyMatImage
struct LazyMatImage: Codable {
    var imageHash: Hash?
}

// MARK: - ZenidShared.EyesInfo
struct EyesInfo: Codable {
    var boxLeftTopRel: PointF?
    var boxRightBottomRel: PointF?
}

// MARK: - ZenidShared.Mrz
struct Mrz: Codable {
    var birthDate: String?
    var birthDateVerified: Bool?
    var documentNumber: String?
    var documentNumberVerified: Bool?
    var expiryDate: String?
    var expiryDateVerified: Bool?
    var givenName: String?
    var checksumVerified: Bool?
    var checksumDigit: Int?
    var lastName: String?
    var nationality: String?
    var sex: String?
    var birthdateChecksum: Int?
    var documentNumChecksum: Int?
    var expiryChecksum: Int?
    var issueDate: String?
    var additionalData: String?
    var additionalData2: String?
    var issuer: String?
    var birthDateParsed: String?
    var expiryDateParsed: String?
    var issueDateParsed: String?
    var mrzDefType: String?
    var birthNumber: String?
    var birthNumberChecksum: Int?
    var birthNumberVerified: Bool?
    var secondaryDocumentNumber: String?
    var secondaryDocumentRole: String?
    var secondaryDocumentNumberChecksum: Int?
    var secondaryDocumentNumberVerified: Bool?
}

// MARK: - Enums
enum SampleType: String, Codable {
    case documentPicture = "DocumentPicture"
    case selfie = "Selfie"
    case selfieVideo = "SelfieVideo"
    case documentVideo = "DocumentVideo"
    case archived = "Archived"
    case unknown = "Unknown"
    case edoklad = "EDoklad"
    case licencePlate = "LicensePlate"
}

enum SampleState: String, Codable {
    case notDone = "NotDone"
    case done = "Done"
    case error = "Error"
    case operatorPending = "Operator"
    case rejected = "Rejected"
    case archived = "Archived"
}

// MARK: - ZenidShared.MineAllResult
struct MineAllResult: Codable {
    var firstName: MinedText?
    var lastName: MinedText?
    var address: MinedAddress?
    var birthAddress: MinedText?
    var birthLastName: MinedText?
    var birthNumber: MinedRc?
    var birthDate: MinedDate?
    var expiryDate: MinedDate?
    var issueDate: MinedDate?
    var idCardNumber: MinedText?
    var drivingLicenseNumber: MinedText?
    var passportNumber: MinedText?
    var sex: MinedSex?
    var nationality: MinedText?
    var authority: MinedText?
    var maritalStatus: MinedMaritalStatus?
    var photo: MinedPhoto?
    var signature: MinedImage?
    var mrz: MinedMrz?
    var documentCode: String?
    var documentCountry: String?
    var documentRole: String?
    var pageCode: String?
    var height: MinedText?
    var eyesColor: MinedText?
    var carNumber: MinedText?
    var visaNumber: MinedText?
    var firstNameOfParents: MinedText?
    var residencyNumber: MinedText?
    var residencyNumberPhoto: MinedText?
    var fathersName: MinedText?
    var residencyPermitDescription: MinedText?
    var residencyPermitCode: MinedText?
    var gunLicenseNumber: MinedText?
    var titles: MinedText?
    var titlesAfter: MinedText?
    var specialRemarks: MinedText?
    var mothersName: MinedText?
    var healthInsuranceCardNumber: MinedText?
    var healthInsuranceNumber: MinedText?
    var insuranceCompanyCode: MinedText?
    var issuingCountry: MinedText?
    var fathersBirthDate: MinedDate?
    var fathersSurname: MinedText?
    var fathersBirthNumber: MinedText?
    var fathersBirthSurname: MinedText?
    var mothersBirthDate: MinedDate?
    var mothersSurname: MinedText?
    var mothersBirthNumber: MinedText?
    var mothersBirthSurname: MinedText?
    var birthCertificateNumber: MinedText?
    var changeOfData: MinedText?
}

// MARK: - ZenidWeb.Classes.FieldOcrResult
struct FieldOcrResult: Codable {
    var fieldId: String?
    var confidence: Int?
    var ocrResult: String?
    var ocrRawResult: String?
}

// MARK: - ZenidShared.Hash
struct Hash: Codable {
    var asText: String?
    var isNull: Bool?
}

// MARK: - System.Drawing.PointF
struct PointF: Codable {
    var isEmpty: Bool?
    var x: Double?
    var y: Double?
}

// MARK: - ZenidShared.MinedText
struct MinedText: Codable {
    var text: String?
    var confidence: Int?
}

// MARK: - ZenidShared.MinedAddress
struct MinedAddress: Codable {
    var id: String?
    var a1: String?
    var a2: String?
    var a3: String?
    var a4: String?
    var administrativeAreaLevel1: String?
    var administrativeAreaLevel2: String?
}

// MARK: - Placeholder Structures
typealias MinedRc = MinedText
typealias MinedDate = MinedText
typealias MinedSex = MinedText
typealias MinedMaritalStatus = MinedText
typealias MinedPhoto = MinedText
typealias MinedImage = MinedText
typealias MinedMrz = MinedText
