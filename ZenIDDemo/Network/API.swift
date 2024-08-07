//
//  API.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 15.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation

enum API { }

extension API {
    /// Create an endpoint for testing the backend connection with a simple GET request
    ///
    /// - Returns: Endpoint of the ListSamplesResponse type
    static func testConnection() -> Endpoint<ListSamplesResponse> {
        return Endpoint<ListSamplesResponse>(method: Method.get,
                                             path: "samples",
                                             parameters: ["timestamp": Int(1000 * Date().timeIntervalSince1970)])
    }

    /// Create an endpoint for init SDK
    ///
    /// - Parameter token: Challenge token generated by SDK function
    /// - Returns: Endpoint of the InitSdkResponse type
    static func initSdk(token: String) -> Endpoint<InitSdkResponse> {
        guard let apiKey = Credentials.shared.apiKey, !apiKey.isEmpty else {
            fatalError("Missing API key. Please get API key from backend developer!")
        }
        return Endpoint<InitSdkResponse>(method: Method.get,
                                         path: "initSdk",
                                         parameters: ["token": token])
    }

    /// Create an endpoint for sending the investigate request to the backend
    ///
    /// - Parameter sampleIds: Array of previously sent samples IDs
    /// - Returns: Endpoint of the InvestigateResponse type
    static func investigateSamples(sampleIds: [String], profile: String) -> Endpoint<InvestigateResponse> {
        return Endpoint<InvestigateResponse>(method: Method.get,
                                             path: "investigateSamples",
                                             parameters: ["sampleIDs": sampleIds, "profile": profile])
    }

    /// Create an upload endpoint for sending a single image sample to backend
    ///
    /// - Parameter image: Image info and data
    /// - Returns: Endpoint of the UploadResponse type
    static func uploadSample(image: ImageInput, profile: String) -> UploadEndpoint<UploadSampleResponse> {
        var data = image.imageData
        let typeKey = "expectedSampleType"
        let roleKey = "role"
        let countryKey = "country"
        let pageKey = "pageCode"
        let documentCodeKey = "documentCode"
        let profileKey = "profile"
        let sampleType = UploadedSampleType.from(photoType: image.photoType, documentType: image.documentType, dataType: image.dataType)
        let parameters = [typeKey: sampleType.rawValue,
                          roleKey: image.documentRole?.description ?? "",
                          countryKey: image.country.description,
                          pageKey: image.photoType.pageCode,
                          documentCodeKey: image.documentCode,
                          profileKey: profile,
        ]
        if let signature = image.signature, let signatureData = signature.data(using: .utf8) {
            // parameters[signatureKey] = signature.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            data.append(signatureData)
        }

        return UploadEndpoint<UploadSampleResponse>(path: "sample", data: data, parameters: parameters)
    }

    /// Create an upload endpoint for sending a single image sample to backend
    ///
    /// - Parameter image: Image info and data
    /// - Returns: Endpoint of the UploadResponse type
    static func uploadSampleMultipart(image: ImageInput, profile: String) -> MultipartUploadEndpoint<UploadSampleResponse> {
        var data = [MultiDataPart(type: image.dataType == .video ? .video : .photo, data: image.imageData)]
        let typeKey = "expectedSampleType"
        let roleKey = "role"
        let countryKey = "country"
        let pageKey = "pageCode"
        let documentCodeKey = "documentCode"
        let profileKey = "profile"
        let sampleType = UploadedSampleType.from(photoType: image.photoType, documentType: image.documentType, dataType: image.dataType)
        let parameters = [typeKey: sampleType.rawValue,
                          roleKey: image.documentRole?.description ?? "",
                          countryKey: image.country.description,
                          pageKey: image.photoType.pageCode,
                          documentCodeKey: image.documentCode,
                          profileKey: profile,
        ]
        if let signature = image.signature, let signatureData = signature.data(using: .utf8) {
            data.append(MultiDataPart(type: .signature, data: signatureData))
        }

        return MultipartUploadEndpoint<UploadSampleResponse>(path: "sample", dataParts: data, parameters: parameters)
    }

    /// Create an upload endpoint for sending a PDF document to backend
    ///
    /// - Parameter data: PDF data
    /// - Returns: Endpoint of the UploadResponse type
    static func uploadPDF(data: Data) -> UploadEndpoint<UploadSampleResponse> {
        let typeKey = "expectedSampleType"
        let countryKey = "country"
        let contentType = "Content-Type"
        let parameters = [typeKey: UploadedSampleType.otherDocument.rawValue,
                          countryKey: "Cz",
                          contentType: "application/pdf"]

        return UploadEndpoint<UploadSampleResponse>(path: "sample", data: data, parameters: parameters)
    }
}
