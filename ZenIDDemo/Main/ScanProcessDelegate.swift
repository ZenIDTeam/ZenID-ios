//
//  ScanProcessDelegate.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Common
import Foundation

/// Represents the result of a single document sample
///
/// - success: Successful result
/// - error: Unsuccessful result with underlying error
enum SampleResult {
    case success
    case error(error: DispatchError)
}

/// Represent the result of a document investigation and the whole scan process
///
/// - success: Succesful result with response data for user feedback
/// - error: Unsuccessful result with underlying error
enum ScanProcessResult {
    case success(data: InvestigateResponse, type: DocumentType)
    case error(error: Error)
}

protocol ScanProcessDelegate: AnyObject {
    /// Called when the scan process requires a photo taken with the camera. When the photo is taken, the delegate should call `processPhoto` method of the `scanProcess`.
    ///
    /// - Parameters:
    ///   - scanProcess: Source scan process
    ///   - photoType: Sample photo type
    func willTakePhoto(scanProcess: ScanProcess, photoType: PhotoType)

    /// Called when the scan process will communicate with the server. The delegate is supposed to provide activity feedback to the user at this time
    ///
    /// - Parameter scanProcess: Source scan process
    func willProcessData(scanProcess: ScanProcess)

    /// Called when the scan process received a response to a sample from the backend server. The delegate can provide a feedback to the user at this time.
    ///
    /// - Parameters:
    ///   - scanProcess: Source scan process
    ///   - result: Result of the sample processing
    func didReceiveSampleResponse(scanProcess: ScanProcess, result: SampleResult)

    /// Called when the scan process received a response to an investigate request from the backend server. This concludes the process.
    ///
    /// - Parameters:
    ///   - scanProcess: Source scan process
    ///   - result: Result of the whole scan process
    func didReceiveInvestigateResponse(scanProcess: ScanProcess, result: ScanProcessResult)

    /// Called after the general document PDF is sent to the backend.
    ///
    /// - Parameters:
    ///   - scanProcess: Source process
    ///   - result: Result
    func didUploadPDF(scanProcess: ScanProcess, result: SampleResult)

    func didFinishAndWaiting(scanProcess: ScanProcess)
}
