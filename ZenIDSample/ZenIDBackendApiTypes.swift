//
//  ZenIDBackendApiTypes.swift
//  ZenID
//

import Foundation

/// Response from sample upload operation.
public struct UploadSampleResponse: Codable {
    public let sampleID: String?
    public let customData: String?
    public let uploadSessionID: String?
    public let errorCode: String?
    public let errorText: String?
    public let imageUrlFormat: String?
    public let uploadTime: String?
    public let processingTimeMs: Int?
    public let minedData: MinedData?

    /// Computed path to face photo (imageUrlFormat with {hash} replaced)
    public let imagePath: String?

    enum CodingKeys: String, CodingKey {
        case sampleID = "SampleID"
        case customData = "CustomData"
        case uploadSessionID = "UploadSessionID"
        case errorCode = "ErrorCode"
        case errorText = "ErrorText"
        case imageUrlFormat = "ImageUrlFormat"
        case uploadTime = "UploadTime"
        case processingTimeMs = "ProcessingTimeMs"
        case minedData = "MinedData"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sampleID = try container.decodeIfPresent(String.self, forKey: .sampleID)
        self.customData = try container.decodeIfPresent(String.self, forKey: .customData)
        self.uploadSessionID = try container.decodeIfPresent(String.self, forKey: .uploadSessionID)
        self.errorCode = try container.decodeIfPresent(String.self, forKey: .errorCode)
        self.errorText = try container.decodeIfPresent(String.self, forKey: .errorText)
        self.imageUrlFormat = try container.decodeIfPresent(String.self, forKey: .imageUrlFormat)
        self.uploadTime = try container.decodeIfPresent(String.self, forKey: .uploadTime)
        self.processingTimeMs = try container.decodeIfPresent(Int.self, forKey: .processingTimeMs)
        self.minedData = try container.decodeIfPresent(MinedData.self, forKey: .minedData)

        // Compute imagePath from imageUrlFormat + hash
        if let hash = minedData?.photo?.imageData?.imageHash?.asText,
           let imageUrlFormat = imageUrlFormat {
            self.imagePath = imageUrlFormat.replacingOccurrences(of: "{hash}", with: hash)
        } else {
            self.imagePath = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(sampleID, forKey: .sampleID)
        try container.encodeIfPresent(customData, forKey: .customData)
        try container.encodeIfPresent(uploadSessionID, forKey: .uploadSessionID)
        try container.encodeIfPresent(errorCode, forKey: .errorCode)
        try container.encodeIfPresent(errorText, forKey: .errorText)
        try container.encodeIfPresent(imageUrlFormat, forKey: .imageUrlFormat)
        try container.encodeIfPresent(uploadTime, forKey: .uploadTime)
        try container.encodeIfPresent(processingTimeMs, forKey: .processingTimeMs)
        try container.encodeIfPresent(minedData, forKey: .minedData)
    }
}

/// Response from investigation operation.
/// This response includes all fields from both investigateSamples and investigate endpoints.
public struct InvestigateSamplesResponse: Codable, Equatable, Hashable {
    public let investigationID: Int?
    public let customData: String?
    public let validatorResults: [ValidatorResult]?
    public let minedData: MinedData?
    public let rank: Rank?
    public let errorCode: String?
    public let errorText: String?
    public let processingTimeMs: Int?
    public let investigationUrl: String?
    public let time: String?

    enum CodingKeys: String, CodingKey {
        case investigationID = "InvestigationID"
        case customData = "CustomData"
        case minedData = "MinedData"
        case rank = "Rank"
        case validatorResults = "ValidatorResults"
        case errorCode = "ErrorCode"
        case errorText = "ErrorText"
        case processingTimeMs = "ProcessingTimeMs"
        case investigationUrl = "InvestigationUrl"
        case time = "Time"
    }
}

/// Validator result from investigation.
public struct ValidatorResult: Codable, Equatable, Hashable {
    public let name: String?
    public let code: Int?
    public let score: Int?
    public let acceptScore: Int?
    public let issues: [ValidatorIssue]?
    public let ok: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case code = "Code"
        case score = "Score"
        case acceptScore = "AcceptScore"
        case issues = "Issues"
        case ok = "Ok"
    }
}

/// Validator issue details.
public struct ValidatorIssue: Codable, Equatable, Hashable {
    public let path: String?
    public let issueDescription: String?
    public let documentCode: String?
    public let fieldId: String?
    public let sampleId: String?
    public let pageCode: String?
    public let sampleType: String?

    enum CodingKeys: String, CodingKey {
        case issueUrl = "IssueUrl"
        case issueDescription = "IssueDescription"
        case documentCode = "DocumentCode"
        case fieldID = "FieldID"
        case sampleID = "SampleID"
        case pageCode = "PageCode"
        case sampleType = "SampleType"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .issueUrl)
        self.issueDescription = try container.decodeIfPresent(String.self, forKey: .issueDescription)
        self.documentCode = try container.decodeIfPresent(String.self, forKey: .documentCode)
        self.fieldId = try container.decodeIfPresent(String.self, forKey: .fieldID)
        self.sampleId = try container.decodeIfPresent(String.self, forKey: .sampleID)
        self.pageCode = try container.decodeIfPresent(String.self, forKey: .pageCode)
        self.sampleType = try container.decodeIfPresent(String.self, forKey: .sampleType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(path, forKey: .issueUrl)
        try container.encodeIfPresent(issueDescription, forKey: .issueDescription)
        try container.encodeIfPresent(documentCode, forKey: .documentCode)
        try container.encodeIfPresent(fieldId, forKey: .fieldID)
        try container.encodeIfPresent(sampleId, forKey: .sampleID)
        try container.encodeIfPresent(pageCode, forKey: .pageCode)
        try container.encodeIfPresent(sampleType, forKey: .sampleType)
    }
}

/// Mined data from document.
public struct MinedData: Codable, Equatable, Hashable {
    public let firstName: String?
    public let lastName: String?
    public let sex: String?
    public let idCardNumber: String?
    public let drivinglicenseNumber: String?
    public let passportNumber: String?
    public let visaNumber: String?
    public let documentRole: String?
    public let photo: PhotoData?

    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
        case sex = "Sex"
        case idCardNumber = "IdcardNumber"
        case drivingLicenseNumber = "DrivinglicenseNumber"
        case passportNumber = "PassportNumber"
        case documentRole = "DocumentRole"
        case visaNumber = "VisaNumber"
        case photo = "Photo"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decodeIfPresent(TextBox.self, forKey: .firstName)?.text
        self.lastName = try container.decodeIfPresent(TextBox.self, forKey: .lastName)?.text
        self.sex = try container.decodeIfPresent(TextBox.self, forKey: .sex)?.text
        self.idCardNumber = try container.decodeIfPresent(TextBox.self, forKey: .idCardNumber)?.text
        self.drivinglicenseNumber = try container.decodeIfPresent(TextBox.self, forKey: .drivingLicenseNumber)?.text
        self.passportNumber = try container.decodeIfPresent(TextBox.self, forKey: .passportNumber)?.text
        self.visaNumber = try container.decodeIfPresent(TextBox.self, forKey: .visaNumber)?.text
        self.documentRole = try container.decodeIfPresent(String.self, forKey: .documentRole)
        self.photo = try container.decodeIfPresent(PhotoData.self, forKey: .photo)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let firstName {
            try container.encode(TextBox(text: firstName), forKey: .firstName)
        }
        if let lastName {
            try container.encode(TextBox(text: lastName), forKey: .lastName)
        }
        if let sex {
            try container.encode(TextBox(text: sex), forKey: .sex)
        }
        if let idCardNumber {
            try container.encode(TextBox(text: idCardNumber), forKey: .idCardNumber)
        }
        if let drivinglicenseNumber {
            try container.encode(TextBox(text: drivinglicenseNumber), forKey: .drivingLicenseNumber)
        }
        if let passportNumber {
            try container.encode(TextBox(text: passportNumber), forKey: .passportNumber)
        }
        if let visaNumber {
            try container.encode(TextBox(text: visaNumber), forKey: .visaNumber)
        }
        try container.encodeIfPresent(documentRole, forKey: .documentRole)
        try container.encodeIfPresent(photo, forKey: .photo)
    }
}

/// Photo data from document containing face image hash.
public struct PhotoData: Codable, Equatable, Hashable {
    public let imageData: PhotoImageData?

    enum CodingKeys: String, CodingKey {
        case imageData = "ImageData"
    }
}

/// Image data containing hash for face photo URL.
public struct PhotoImageData: Codable, Equatable, Hashable {
    public let imageHash: PhotoImageHash?

    enum CodingKeys: String, CodingKey {
        case imageHash = "ImageHash"
    }
}

/// Hash value used to construct face photo URL.
public struct PhotoImageHash: Codable, Equatable, Hashable {
    public let asText: String?

    enum CodingKeys: String, CodingKey {
        case asText = "AsText"
    }
}

/// Helper structure for decoding text fields.
struct TextBox: Codable {
    let text: String?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
    }
}

/// Rank information from investigation.
public struct Rank: Codable, Equatable, Hashable {
    public let overall: String
    public let samples: [InvestigationSample]

    enum CodingKeys: String, CodingKey {
        case overall = "Overall"
        case samples = "Samples"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overall = try container.decodeIfPresent(String.self, forKey: .overall) ?? "F"
        self.samples = try container.decodeIfPresent([InvestigationSample].self, forKey: .samples) ?? []
    }
}

/// Sample information from investigation.
public struct InvestigationSample: Codable, Equatable, Hashable {
    public let type: String
    public let rank: String
    public let page: String?
    public let sampleId: String?
    public let documentCode: String?

    enum CodingKeys: String, CodingKey {
        case sampleType = "SampleType"
        case documentPage = "Page"
        case rank = "Rank"
        case documentCode = "DocumentCode"
        case sampleId = "SampleID"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .sampleType)
        self.page = try container.decodeIfPresent(String.self, forKey: .documentPage)
        self.rank = try container.decode(String.self, forKey: .rank)
        self.documentCode = try container.decodeIfPresent(String.self, forKey: .documentCode)
        self.sampleId = try container.decodeIfPresent(String.self, forKey: .sampleId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .sampleType)
        try container.encodeIfPresent(page, forKey: .documentPage)
        try container.encode(rank, forKey: .rank)
        try container.encodeIfPresent(documentCode, forKey: .documentCode)
        try container.encodeIfPresent(sampleId, forKey: .sampleId)
    }
}

/// Response from profiles/list operation.
public struct ProfilesResponse: Codable {
    public let results: [String]?
    public let errorCode: String?
    public let errorText: String?
    public let processingTimeMs: Int?

    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case errorCode = "ErrorCode"
        case errorText = "ErrorText"
        case processingTimeMs = "ProcessingTimeMs"
    }
}
