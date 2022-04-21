//
//  ScanProcess.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 30/01/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS

/// ScanProcess represents the process of scanning a document. It handles the necessary network requests and validates the scanned document images.
final class ScanProcess {
    
    /// Queue for thread safe access to requestsToScan array
    private let requestsQueue = DispatchQueue(label: "cz.trask.ZenID.requestsToScan", attributes: .concurrent)
    
    /// Remaining document sides / selfies to scan for the given document. This array changes during the process
    private var requestsToScan: [PhotoType] = []
    
    /// IDs of successfully scanned document pages. These are sent in the final investigate request.
    private var finishedSampleIDs: [String] = []
    
    /// PDF helper for sending general documents in PDF format
    private let pdfHelper = PDFHelper()
    
    /// Document type that the class will process
    let documentType: DocumentType
    
    /// Document country
    let country: Country
    
    /// List of images already taken for uploading in a PDF format
    var pdfImages: [ImageInput] = []
    
    /// Delegate that handles camera requests and UI navigation on behalf of the scan process
    weak var delegate: ScanProcessDelegate?
    
    private var requestsCount: Int
    
    /// Initialize the scan process with a specific document type
    ///
    /// - Parameter documentType: Document type to scan
    init(documentType: DocumentType, country: Country, selfieSelectionLoader: SelfieSelectionLoader) {
        self.documentType = documentType
        self.country = country
        requestsToScan = documentType.scanRequests
        requestsCount = requestsToScan.count
        let faceMode = try? selfieSelectionLoader.load()
        if faceMode == nil {
            requestsToScan = requestsToScan.filter({ $0 != .face })
        }
        requestsCount = requestsToScan.count
    }
    
    deinit {
        ApplicationLogger.shared.Verbose("Scan process deinit")
        cleanUpStorage()
    }
    
    /// Starts the process. This method should only be called after the delegate is set
    func start() {
        if nil == delegate {
            ApplicationLogger.shared.Error("Delegate must be set prior to calling startProcess")
            fatalError("Delegate must be set prior to calling startProcess")
        }
        self.scanNextSample()
    }
    
    /// Process response to a sample sent to the backend. It uses the `Dispatcher` to validate the result. If the result is not satisfactory, the request to scan is added to the end of `requestsToScan` array
    ///
    /// - Parameters:
    ///   - input: The sample that was sent
    ///   - response: The received response
    private func processSampleResponse(input: ImageInput, response: UploadSampleResponse) {
        let dispatchResult = self.dispatch(input, response)
        switch dispatchResult {
        case .completed(let addSample):
            if let addedSample = addSample {
                self.delegate?.didReceiveSampleResponse(scanProcess: self, result: .success)
                self.addSuccessfulSample(addedSample)
            }
        case .rescan(let photoType, let error):
            if let error = error {
                self.delegate?.didReceiveSampleResponse(scanProcess: self, result: .error(error: error))
            }
            self.rescanSample(type: photoType)
        }
    }
    
    /// Add the sample to the end of `requestsToScan` array to be taken again
    ///
    /// - Parameter type: Type of the photo sample to take (ie. front, back or selfie)
    private func rescanSample(type: PhotoType) {
        requestsQueue.async(flags: .barrier) { [unowned self] in
            self.requestsToScan.append(type)
        }
        self.scanNextSample()
    }
    
    /// Scan the next sample in row
    private func scanNextSample() {
        requestsQueue.async(flags: .barrier) { [unowned self] in
            if self.requestsToScan.count > 0 {
                let type = self.requestsToScan.removeFirst()
                self.delegate?.willTakePhoto(scanProcess: self, photoType: type)
            }
        }
    }
    
    /// Add an ID of a successfully processed sample to the array of resulting IDs. If enough sample IDs are added in order to represent all the scan requests, the final investigate request is sent to the backend.
    ///
    /// - Parameter sampleID: sample ID
    private func addSuccessfulSample(_ sampleID: String) {
        self.finishedSampleIDs.append(sampleID)
        if isFinished() {
            self.delegate?.willProcessData(scanProcess: self)
            self.investigateSamples(self.finishedSampleIDs)
        }
    }
    
    /// Process a document sample photo acquired using the camera
    ///
    /// - Parameters:
    ///   - imageData: the image data
    ///   - type: photo sample type
    public func processPhoto(imageData: Data, type: PhotoType, result: UnifiedResult?, dataType: DataType) {
        checkIfIsFinishedAndCallDelegate()
        self.scanNextSample()
        let imageInput = ImageInput(
            imageData: result?.signature?.image ?? imageData,
            documentType: documentType,
            documentRole: RecoglibMapper.documentRole(from: documentType, role: result?.role),
            documentCode: result?.code == nil ? documentType.rawValue : String(describing: result!.code!),
            photoType: result?.page == nil ? type : (result!.page == .Back ? .back : .front),
            country: result?.country ?? country,
            signature: result?.signature?.signature,
            dataType: dataType
        )
        if self.documentType == .otherDocument {
            // in case of other documents we are uploading only the whole file in completion of this controller
            self.pdfImages.append(imageInput)
            self.pdfHelper.createPDF(from: imageData)
        } else {
            self.uploadSample(imageInput)
        }
    }
    
    private func checkIfIsFinishedAndCallDelegate() {
        if isScanningFinished() {
            delegate?.didFinishAndWaiting(scanProcess: self)
        }
    }
    
    private func isScanningFinished() -> Bool {
        requestsToScan.isEmpty
    }
    
    private func isFinished() -> Bool {
        finishedSampleIDs.count >= requestsCount
    }
    
    /// Upload general document PDF after all the samples have been taken
    public func uploadPhotosPDF() {
        self.proceedPDFUpload()
    }
    
    /// Delete the temporary PDF files
    public func cleanUpStorage() {
        pdfHelper.cleanup()
    }
}

// MARK: - Network requests

private extension ScanProcess {
    /// Dispatch the image and response to `Dispatcher` for validation
    ///
    /// - Parameters:
    ///   - image: image sample data
    ///   - response: response from backend
    /// - Returns: Result of the dispatch action
    func dispatch(_ image: ImageInput, _ response: UploadSampleResponse) -> DispatchResult {
        return Dispatcher().dispatch(image: image, response: response)
    }
    
    /// Upload photo sample to the backend
    ///
    /// - Parameter image: Uploaded image data and info
    func uploadSample(_ image: ImageInput) {
        if self.finishedSampleIDs.count + 1 >= self.requestsCount {
            self.delegate?.willProcessData(scanProcess: self)
        }
        Client()
            .upload(API.uploadSample(image: image)) { [weak self] (response, error) in
                guard let self = self else { return }
                if let response = response {
                    self.processSampleResponse(input: image, response: response)
                }
                if let error = error {
                    self.delegate?.didReceiveInvestigateResponse(scanProcess: self, result: .error(error: error))
                }
        }
    }
    
    /// Send the investigate request to the backend after required number of samples have been successfully processed. The IDs are received from backend when each sample is processed.
    ///
    /// - Parameter sampleIds: Array of the processed sample IDs.
    func investigateSamples(_ sampleIds: [String]) {
        Client()
            .request(API.investigateSamples(sampleIds: sampleIds)) { [weak self] (response, error) in
                guard let self = self else { return }
                if let response = response {
                    if let errorCode = response.ErrorCode {
                        self.delegate?.didReceiveInvestigateResponse(scanProcess: self, result: .error(error: errorCode))
                    }
                    else {
                        self.delegate?.didReceiveInvestigateResponse(scanProcess: self, result: .success(data: response, type: self.documentType))
                    }
                    return
                }
                if let error = error {
                    self.delegate?.didReceiveInvestigateResponse(scanProcess: self, result: .error(error: error))
                }
                else {
                    // This is an unexpected error, probably there's something wrong on the backend, ie. the model has changed and decoding doesn't work anymore
                    self.delegate?.didReceiveInvestigateResponse(scanProcess: self, result: .error(error: InvestigateResponseError.invalidServerResponse))
                }
        }
    }

    /// Upload the general document PDF to the backend
    ///
    /// - Parameter fileUrl: Local PDF file URL
    func uploadPdf(_ fileUrl: URL) {
        guard let data = try? Data(contentsOf: fileUrl) else {
            self.delegate?.didUploadPDF(scanProcess: self, result: .error(error: .networkError))
            return
        }
        Client().upload(API.uploadPDF(data: data)) { [weak self] (response, error) in
            guard let self = self else { return }
            self.pdfHelper.cleanup()
            if let _ = response {
                self.delegate?.didUploadPDF(scanProcess: self, result: .success)
            }
            if let _ = error {
                self.delegate?.didUploadPDF(scanProcess: self, result: .error(error: .networkError))
            }
        }
    }

    /// Called when the required pages of the PDF file have been scanned in order to finish and close the PDF file and upload it to the backend.
    func proceedPDFUpload() {
        self.delegate?.willProcessData(scanProcess: self)
        self.pdfHelper.merge()
        self.uploadPdf(URL(fileURLWithPath: self.pdfHelper.finalFilePath))
    }
}
