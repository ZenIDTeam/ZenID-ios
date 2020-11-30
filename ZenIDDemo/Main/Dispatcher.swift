//
//  Dispatcher.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 25.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation

/// The Dispatcher handles validation of sample responses from the backend.
public class Dispatcher {
    
    /// Validate a sample response to give the user feedback.
    ///
    /// - Note: Currently the backend doesn't process images that it does't immediately recognize, so the sampleType is mostly empty resulting in the general "Unreadable picture" result being sent if there is any problem with the sample.
    /// - Parameters:
    ///   - image: The image sample that was sent
    ///   - response: Response from the backend
    /// - Returns: Result of the validation
    func dispatch(image: ImageInput, response: UploadSampleResponse ) -> DispatchResult {

        #if DEBUG
        NSLog("Dispatching document %@ image type: %@", String(describing: image.documentType), String(describing: image.photoType))
        #endif

        guard let sampleType = response.SampleType else {
            #if DEBUG
            NSLog("Response sample type missing, unrecognized estimated document type")
            #endif
            return rescan(image, response, .unknownEstimatedDocumentType)
        }
        
        if sampleType == .documentPicture {
        
            guard let minedData = response.MinedData else {
                #if DEBUG
                NSLog("Mined data missing")
                #endif
                return rescan(image, response, .unknownEstimatedDocumentType)
            }
            
            guard let resultDocumentCode = minedData.DocumentCode else {
                #if DEBUG
                NSLog("Document code missing")
                #endif
                return rescan(image, response, .unknownEstimatedDocumentType)
            }
            
            guard resultDocumentCode.isTypeOfDocument(type: image.documentType) else {
                #if DEBUG
                NSLog("Document code differs from expected document")
                #endif
                return rescan(image, response, .documentTypesDontMatch)
            }
            
            guard let pageCode = minedData.PageCode else {
                #if DEBUG
                NSLog("Document page code missing")
                #endif
                return rescan(image, response, .unknownEstimatedDocumentType)
            }
        
            if pageCode == .back && image.photoType != .back  {
                #if DEBUG
                NSLog("Document page mismatch ")
                #endif
                return rescan(image, response, .incorrectlyRecognizedAsBack)
            }
            
            if pageCode == .front && image.photoType != .front  {
                #if DEBUG
                NSLog("Document page mismatch ")
                #endif
                return rescan(image, response, .incorrectlyRecognizedAsFront)
            }
        }
        else if sampleType == .documentVideo {
            
            guard let state = response.State, state == .done else {
                #if DEBUG
                NSLog("Invalid document video")
                #endif
                return rescan(image, response, .unknownEstimatedDocumentType)
            }
        }
        else if sampleType == .selfie {
            
            guard image.photoType == .selfie else {
                #if DEBUG
                NSLog("Received selfie when expected a document")
                #endif
                return rescan(image, response, .incorrectlyRecognizedAsSelfie)
            }
        }
        else {
            #if DEBUG
            NSLog("Unreadable picture or unknown error")
            #endif
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
        #if DEBUG
        NSLog("Dispatcher: Document accepted.")
        #endif
        return .completed(sampleID: response.SampleID)
    }
    
    /// Rescan the sample after the validation failed
    ///
    /// - Parameters:
    ///   - image: Input image
    ///   - response: Backend response
    ///   - error: Resulting error
    /// - Returns: An unsuccessful dispatch result
    private func rescan(_ image: ImageInput, _ response: UploadSampleResponse, _ error: DispatchError ) -> DispatchResult {
        return .rescan(photoType: image.photoType, error: error)
    }
}
