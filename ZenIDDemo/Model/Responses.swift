//
//  Responses.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 20/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

enum InvestigateResponseError: String, Error, Decodable {
    case unknownSampleId = "UnknownSampleID"
    case unknownUploadSessionId = "UnknownUploadSessionID"
    case emptyBody = "EmptyBody"
    case internalServerError = "InternalServerError"
    case invalidTimestamp = "InvalidTimeStamp"
    case invalidServerResponse = "InvalidServerResponse"
}

struct InitSdkResponse: Decodable {
    var Response: String?
    var ErrorCode: String?
    var ErrorText: String?
    var MessageType: String?
}

struct InvestigateResponse: Decodable {
    var InvestigationID: Int?
    var CustomData: String?
    var MinedData: MineAllResult?
    var InvestigationUrl: String?
    var ValidatorResults: [InvestigationValidatorResponse]?
    var State: SampleItemState?
    var ErrorCode: InvestigateResponseError?
    var ErrorText: String?
}

struct InvestigationValidatorResponse: Decodable {
    var Name: String?
    var Code: Int?
    var Score: Int?
    var AcceptScore: Int?
    var Issues: [InvestigationIssueResponse]?
    var Ok: Bool?
}

struct InvestigationIssueResponse: Decodable {
    var IssueUrl: String?
    var IssueDescription: String?
    var DocumentCode: String?
    var FieldID: String?
    var SampleID: String?
    var PageCode: String?
    var SampleType: SampleType?
    
    var documentCode: RecogLib_iOS.DocumentCodes? {
        RecogLib_iOS.DocumentCodes(stringValue: DocumentCode ?? "")
    }
}

struct ListSamplesResponse: Decodable {
    struct SampleItem: Decodable {
        var SampleID: String?
        var ParentSampleID: String?
        var CustomData: String?
        var UploadSessionID: String?
        var State: SampleItemState?
    }

    var Results: [SampleItem]?
    var TimeStamp: Int?
    var ErrorCode: InvestigateResponseError?
    var ErrorText: String?
}

struct UploadSampleResponse: Decodable {
    var SampleID: String?
    var CustomData: String?
    var UploadSessionID: String?
    var SampleType: SampleType?
    var MinedData: MineAllResult?
    var State: SampleItemState?
    var ProjectedImage: Hash?
    var ParentSampleID: String?
    var AnonymizedImage: String?
    var ImageUrlFormat: String?
    var ImagePageCount: Int?
    var Subsamples: [UploadSampleResponse]?
    var ErrorCode: InvestigateResponseError?
    var ErrorText: String?
}
