//
//  Responses.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 20/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

public enum InvestigateResponseError: String, Error, Decodable {
    case unknownSampleId = "UnknownSampleID"
    case unknownUploadSessionId = "UnknownUploadSessionID"
    case emptyBody = "EmptyBody"
    case internalServerError = "InternalServerError"
    case invalidTimestamp = "InvalidTimeStamp"
    case invalidServerResponse = "InvalidServerResponse"
}

public struct InitSdkResponse: Decodable {
    public var Response: String?
    public var ErrorCode: String?
    public var ErrorText: String?
    public var MessageType: String?
}

public struct InvestigateResponse: Decodable {
    public var InvestigationID: Int?
    public var CustomData: String?
    public var MinedData: MineAllResult?
    public var InvestigationUrl: String?
    public var ValidatorResults: [InvestigationValidatorResponse]?
    public var State: SampleItemState?
    public var ErrorCode: InvestigateResponseError?
    public var ErrorText: String?
}

public struct InvestigationValidatorResponse: Decodable {
    public var Name: String?
    public var Code: Int?
    public var Score: Int?
    public var AcceptScore: Int?
    public var Issues: [InvestigationIssueResponse]?
    public var Ok: Bool?
}

public struct InvestigationIssueResponse: Decodable {
    public var IssueUrl: String?
    public var IssueDescription: String?
    public var DocumentCode: String?
    public var FieldID: String?
    public var SampleID: String?
    public var PageCode: String?
    public var SampleType: SampleType?
    
    public var documentCode: RecogLib_iOS.DocumentCodes? {
        // TODO: check implementation
        RecogLib_iOS.DocumentCodes(stringValue: documentCode?.description ?? "")
    }
}

public struct ListSamplesResponse: Decodable {
    public struct SampleItem: Decodable {
        public var SampleID: String?
        public var ParentSampleID: String?
        public var CustomData: String?
        public var UploadSessionID: String?
        public var State: SampleItemState?
    }

    public var Results: [SampleItem]?
    public var TimeStamp: Int?
    public var ErrorCode: InvestigateResponseError?
    public var ErrorText: String?

    public init(Results: [SampleItem]? = nil, TimeStamp: Int? = nil, ErrorCode: InvestigateResponseError? = nil, ErrorText: String? = nil) {
        self.Results = Results
        self.TimeStamp = TimeStamp
        self.ErrorCode = ErrorCode
        self.ErrorText = ErrorText
    }
}

public struct UploadSampleResponse: Decodable {
    public var SampleID: String?
    public var CustomData: String?
    public var UploadSessionID: String?
    public var SampleType: SampleType?
    public var MinedData: MineAllResult?
    public var State: SampleItemState?
    public var ProjectedImage: Hash?
    public var ParentSampleID: String?
    public var AnonymizedImage: String?
    public var ImageUrlFormat: String?
    public var ImagePageCount: Int?
    public var Subsamples: [UploadSampleResponse]?
    public var ErrorCode: InvestigateResponseError?
    public var ErrorText: String?
}
