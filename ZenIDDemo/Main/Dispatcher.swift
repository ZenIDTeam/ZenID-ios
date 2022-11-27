//
//  Dispatcher.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 25.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Common
import Foundation
import RecogLib_iOS

/// The Dispatcher handles validation of sample responses from the backend.
public class Dispatcher {
    /// Validate a sample response to give the user feedback.
    ///
    /// - Note: Currently the backend doesn't process images that it does't immediately recognize, so the sampleType is mostly empty resulting in the general "Unreadable picture" result being sent if there is any problem with the sample.
    /// - Parameters:
    ///   - image: The image sample that was sent
    ///   - response: Response from the backend
    /// - Returns: Result of the validation
    func dispatch(image: ImageInput, response: UploadSampleResponse) -> DispatchResult {
        ApplicationLogger.shared.Verbose("Dispatching document \(String(describing: image.documentType)) image type: \(String(describing: image.photoType))")

        guard let sampleType = response.SampleType else {
            ApplicationLogger.shared.Verbose("Response sample type missing, unrecognized estimated document type")
            return rescan(image, response, .unknownEstimatedDocumentType)
        }

        if image.documentType == .filter {
            return proceedToNext(image, response)
        }

        if sampleType == .documentPicture {
            guard let minedData = response.MinedData else {
                ApplicationLogger.shared.Verbose("Mined data missing")
                return rescan(image, response, .unknownEstimatedDocumentType)
            }

            guard let resultDocumentCode = minedData.documentCode else {
                ApplicationLogger.shared.Verbose("Document code missing")
                return rescan(image, response, .unknownEstimatedDocumentType)
            }

            guard resultDocumentCode.isTypeOfDocument(type: image.documentCode) else {
                ApplicationLogger.shared.Verbose("Document code differs from expected document")
                return rescan(image, response, .documentTypesDontMatch)
            }

            guard let pageCode = minedData.PageCode else {
                ApplicationLogger.shared.Verbose("Document page code missing")
                return rescan(image, response, .unknownEstimatedDocumentType)
            }

            if pageCode == .back && image.photoType != .back {
                ApplicationLogger.shared.Verbose("Document page mismatch")
                return rescan(image, response, .incorrectlyRecognizedAsBack)
            }

            if pageCode == .front && image.photoType != .front {
                ApplicationLogger.shared.Verbose("Document page mismatch")
                return rescan(image, response, .incorrectlyRecognizedAsFront)
            }
        } else if sampleType == .documentVideo {
            guard let state = response.State, state == .done else {
                ApplicationLogger.shared.Verbose("Invalid document video")
                return rescan(image, response, .unknownEstimatedDocumentType)
            }
        } else if sampleType == .selfieVideo {
            guard let state = response.State, state == .done else {
                ApplicationLogger.shared.Verbose("Invalid selfie video")
                return rescan(image, response, .unknownEstimatedDocumentType)
            }
        } else if sampleType == .selfie {
            guard image.photoType == .face else {
                ApplicationLogger.shared.Verbose("Received selfie when expected a document")
                return rescan(image, response, .incorrectlyRecognizedAsSelfie)
            }
        } else {
            ApplicationLogger.shared.Verbose("Unreadable picture or unknown error")
            return rescan(image, response, .unreadablePicture)
        }

        return proceedToNext(image, response)
    }

    /// The validation was successful and the sample was accepted, so the process can continue to the next step.
    ///
    /// - Parameters:
    ///   - image: Input image
    ///   - response: Backend response
    /// - Returns: A succesful dispatch result
    private func proceedToNext(_ image: ImageInput, _ response: UploadSampleResponse) -> DispatchResult {
        ApplicationLogger.shared.Verbose("Dispatcher: Document accepted.")
        return .completed(sampleID: response.SampleID)
    }

    /// Rescan the sample after the validation failed
    ///
    /// - Parameters:
    ///   - image: Input image
    ///   - response: Backend response
    ///   - error: Resulting error
    /// - Returns: An unsuccessful dispatch result
    private func rescan(_ image: ImageInput, _ response: UploadSampleResponse, _ error: DispatchError) -> DispatchResult {
        return .rescan(photoType: image.photoType, error: error)
    }
}
