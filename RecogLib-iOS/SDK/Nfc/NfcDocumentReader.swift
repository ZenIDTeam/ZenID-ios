//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//

import CoreNFC
import Foundation
import UIKit

public class NfcDocumentReader: NSObject, NfcDocumentReaderProtocol {
    private typealias NFCCheckedContinuation = CheckedContinuation<NfcData, Error>
    private var nfcContinuation: NFCCheckedContinuation?

    private var passport: NFCDocumentModel = NFCDocumentModel()

    private var readerSession: NFCTagReaderSession?
    private var currentlyReadingDataGroup: DataGroupId?

    private var dataGroupsToRead: [DataGroupId] = []
    private var readAllDatagroups = false
    private var skipSecureElements = true
    private var skipPACE = false

    private var bacHandler: BACHandler?
    private var paceHandler: PACEHandler?
    private var mrzKey: String = ""

    private var scanCompletedHandler: ((NFCDocumentModel?, NfcDocumentReaderError?) -> Void)!
    private var displayMessageProvider: NfcDisplayMessageProvider
    private var shouldNotReportNextReaderSessionInvalidationErrorUserCanceled: Bool = false

    public init(mrzKey: String, displayMessageProvider: NfcDisplayMessageProvider? = nil) {
        self.mrzKey = mrzKey
        self.displayMessageProvider = displayMessageProvider ?? DefaultMesageProvider()
        super.init()
    }

    deinit {
        ApplicationLogger.shared.Debug("NfcDocumentReader.deinit()")
    }

    public func read() async throws -> NfcData {
        try await read(skipSecureElements: true, skipPACE: true)
    }

    public func read(skipSecureElements: Bool = true, skipPACE: Bool = false) async throws -> NfcData {
        passport = NFCDocumentModel()

        self.skipPACE = skipPACE

        dataGroupsToRead.removeAll()
        dataGroupsToRead.append(contentsOf: [])
        self.skipSecureElements = skipSecureElements
        currentlyReadingDataGroup = nil
        bacHandler = nil
        paceHandler = nil

        // If no tags specified, read all
        if dataGroupsToRead.count == 0 {
            // Start off with .COM, will always read (and .SOD but we'll add that after), and then add the others from the COM
            dataGroupsToRead.append(contentsOf: [.COM, .SOD])
            readAllDatagroups = true
        } else {
            // We are reading specific datagroups
            readAllDatagroups = false
        }

        guard NFCNDEFReaderSession.readingAvailable else {
            throw NfcDocumentReaderError.NFCNotSupported
        }

        if NFCTagReaderSession.readingAvailable {
            readerSession = NFCTagReaderSession(pollingOption: [.iso14443], delegate: self, queue: nil)

            updateReaderSessionMessage(alertMessage: NFCDisplayMessage.requestPresent)
            readerSession?.begin()
        }

        return try await withCheckedThrowingContinuation({ (continuation: NFCCheckedContinuation) in
            self.nfcContinuation = continuation
        })
    }
}

@available(iOS 13, *)
extension NfcDocumentReader: NFCTagReaderSessionDelegate {
    // MARK: - NFCTagReaderSessionDelegate

    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        // If necessary, you may perform additional operations on session start.
        // At this point RF polling is enabled.
        ApplicationLogger.shared.Debug("tagReaderSessionDidBecomeActive")
    }

    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        // If necessary, you may handle the error. Note session is no longer valid.
        // You must create a new session to restart RF polling.
        ApplicationLogger.shared.Debug("tagReaderSession:didInvalidateWithError - \(error.localizedDescription)")
        readerSession?.invalidate()
        readerSession = nil

        if let readerError = error as? NFCReaderError, readerError.code == NFCReaderError.readerSessionInvalidationErrorUserCanceled
            && self.shouldNotReportNextReaderSessionInvalidationErrorUserCanceled {
            shouldNotReportNextReaderSessionInvalidationErrorUserCanceled = false
        } else {
            var userError = NfcDocumentReaderError.UnexpectedError
            if let readerError = error as? NFCReaderError {
                ApplicationLogger.shared.Error("tagReaderSession:didInvalidateWithError - Got NFCReaderError - \(readerError.localizedDescription)")
                switch readerError.code {
                case NFCReaderError.readerSessionInvalidationErrorUserCanceled:
                    ApplicationLogger.shared.Error("     - User cancelled session")
                    userError = NfcDocumentReaderError.UserCanceled
                default:
                    ApplicationLogger.shared.Error("     - some other error - \(readerError.localizedDescription)")
                    userError = NfcDocumentReaderError.UnexpectedError
                }
            } else {
                ApplicationLogger.shared.Error("tagReaderSession:didInvalidateWithError - Received error - \(error.localizedDescription)")
            }
            nfcContinuation?.resume(throwing: userError)
            nfcContinuation = nil
        }
    }

    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        ApplicationLogger.shared.Debug("tagReaderSession:didDetect - \(tags[0])")
        if tags.count > 1 {
            ApplicationLogger.shared.Debug("tagReaderSession:more than 1 tag detected! - \(tags)")

            let errorMessage = NFCDisplayMessage.error(.MoreThanOneTagFound)
            invalidateSession(errorMessage: errorMessage, error: NfcDocumentReaderError.MoreThanOneTagFound)
            return
        }

        let tag = tags.first!
        var passportTag: NFCISO7816Tag
        switch tags.first! {
        case let .iso7816(tag):
            passportTag = tag
        default:
            ApplicationLogger.shared.Debug("tagReaderSession:invalid tag detected!!!")

            let errorMessage = NFCDisplayMessage.error(NfcDocumentReaderError.TagNotValid)
            invalidateSession(errorMessage: errorMessage, error: NfcDocumentReaderError.TagNotValid)
            return
        }

        Task { [passportTag] in
            do {
                try await session.connect(to: tag)

                ApplicationLogger.shared.Debug("tagReaderSession:connected to tag - starting authentication")
                self.updateReaderSessionMessage(alertMessage: NFCDisplayMessage.authenticatingWith(0))

                let tagReader = TagReader(tag: passportTag)

                tagReader.progress = { [unowned self] progress in
                    if let dgId = self.currentlyReadingDataGroup {
                        self.updateReaderSessionMessage(alertMessage: NFCDisplayMessage.readingDataGroupProgress(dgId, progress))
                    } else {
                        self.updateReaderSessionMessage(alertMessage: NFCDisplayMessage.authenticatingWith(progress))
                    }
                }

                let documentModel = try await self.startReading(tagReader: tagReader)
                let nfcData = NfcData(document: documentModel)
                nfcContinuation?.resume(returning: nfcData)
                nfcContinuation = nil

            } catch let error as NfcDocumentReaderError {
                let errorMessage = NFCDisplayMessage.error(error)
                self.invalidateSession(errorMessage: errorMessage, error: error)
            } catch let error {
                nfcContinuation?.resume(throwing: NfcDocumentReaderError(from: error as NSError))
                nfcContinuation = nil
                ApplicationLogger.shared.Debug("tagReaderSession:failed to connect to tag - \(error.localizedDescription)")
                let errorMessage = NFCDisplayMessage.error(NfcDocumentReaderError.ConnectionError)
                self.invalidateSession(errorMessage: errorMessage, error: NfcDocumentReaderError.ConnectionError)
            }
        }
    }

    func updateReaderSessionMessage(alertMessage: NFCDisplayMessage) {
        let alertMessage = displayMessageProvider.message(for: alertMessage)
        readerSession?.alertMessage = alertMessage
    }
}

@available(iOS 13, *)
extension NfcDocumentReader {
    func startReading(tagReader: TagReader) async throws -> NFCDocumentModel {
//        if !skipPACE {
//            do {
//                let data = try await tagReader.readCardAccess()
//                ApplicationLogger.shared.Verbose( "Read CardAccess - data \(binToHexRep(data))" )
//                let cardAccess = try CardAccess(data)
//                passport.cardAccess = cardAccess
//
//                ApplicationLogger.shared.Info( "Starting Password Authenticated Connection Establishment (PACE)" )
//
//                let paceHandler = try PACEHandler( cardAccess: cardAccess, tagReader: tagReader )
//                try await paceHandler.doPACE(mrzKey: mrzKey )
//                passport.PACEStatus = .success
//                ApplicationLogger.shared.Debug( "PACE Succeeded" )
//            } catch {
//                passport.PACEStatus = .failed
//                ApplicationLogger.shared.Error( "PACE Failed - falling back to BAC" )
//            }
//
//            _ = try await tagReader.selectPassportApplication()
//        }

        // If either PACE isn't supported, we failed whilst doing PACE or we didn't even attempt it, then fall back to BAC
        if passport.PACEAuthStatus != .success {
            try await doBACAuthentication(tagReader: tagReader)
        }

        // Now to read the datagroups
        try await readDataGroups(tagReader: tagReader)

        updateReaderSessionMessage(alertMessage: NFCDisplayMessage.successfullRead)

        // try await doActiveAuthenticationIfNeccessary(tagReader : tagReader)
        shouldNotReportNextReaderSessionInvalidationErrorUserCanceled = true
        readerSession?.invalidate()

        return passport
    }

//    func doActiveAuthenticationIfNeccessary( tagReader : TagReader) async throws {
//        guard self.passport.activeAuthenticationSupported else {
//            return
//        }
//
//        ApplicationLogger.shared.Info( "Performing Active Authentication" )
//
//        let challenge = generateRandomUInt8Array(8)
//        ApplicationLogger.shared.Verbose( "Generated Active Authentication challange - \(binToHexRep(challenge))")
//        let response = try await tagReader.doInternalAuthentication(challenge: challenge)
//        self.passport.verifyActiveAuthentication( challenge:challenge, signature:response.data )
//    }

    func doBACAuthentication(tagReader: TagReader) async throws {
        currentlyReadingDataGroup = nil

        ApplicationLogger.shared.Info("Starting Basic Access Control (BAC)")

        passport.BACAuthStatus = .failed

        bacHandler = BACHandler(tagReader: tagReader)
        try await bacHandler?.performBACAndGetSessionKeys(mrzKey: mrzKey)
        ApplicationLogger.shared.Info("Basic Access Control (BAC) - SUCCESS!")

        passport.BACAuthStatus = .success
    }

    func readDataGroups(tagReader: TagReader) async throws {
        // Read COM
        var DGsToRead = [DataGroupId]()

        updateReaderSessionMessage(alertMessage: NFCDisplayMessage.readingDataGroupProgress(.COM, 0))
        if let com = try await readDataGroup(tagReader: tagReader, dgId: .COM) as? COM {
            passport.addDataGroup(.COM, dataGroup: com)

            // SOD and COM shouldn't be present in the DG list but just in case (worst case here we read the sod twice)
            DGsToRead = [.SOD] + com.dataGroupsPresent.map { DataGroupId.getIDFromName(name: $0) }
            DGsToRead.removeAll { $0 == .COM }
        }

        if DGsToRead.contains(.DG14) {
            DGsToRead.removeAll { $0 == .DG14 }
            
            if let dg14 = try await readDataGroup(tagReader: tagReader, dgId: .DG14) as? DataGroup14 {
                passport.addDataGroup(.DG14, dataGroup: dg14)
            }
        }

        // If we are skipping secure elements then remove .DG3 and .DG4
        if skipSecureElements {
            DGsToRead = DGsToRead.filter { $0 != .DG3 && $0 != .DG4 }
        }

        if readAllDatagroups != true {
            DGsToRead = DGsToRead.filter { dataGroupsToRead.contains($0) }
        }
        for dgId in DGsToRead {
            updateReaderSessionMessage(alertMessage: NFCDisplayMessage.readingDataGroupProgress(dgId, 0))
            if let dg = try await readDataGroup(tagReader: tagReader, dgId: dgId) {
                passport.addDataGroup(dgId, dataGroup: dg)
            }
        }
    }

    func readDataGroup(tagReader: TagReader, dgId: DataGroupId) async throws -> DataGroup? {
        currentlyReadingDataGroup = dgId
        ApplicationLogger.shared.Info("Reading tag - \(dgId)")
        var readAttempts = 0

        updateReaderSessionMessage(alertMessage: NFCDisplayMessage.readingDataGroupProgress(dgId, 0))

        repeat {
            do {
                let response = try await tagReader.readDataGroup(dataGroup: dgId)
                let dg = try DataGroupParser().parseDG(data: response)
                return dg
            } catch let error as NfcDocumentReaderError {
                ApplicationLogger.shared.Error("TagError reading tag - \(error)")

                // OK we had an error - depending on what happened, we may want to try to re-read this
                // E.g. we failed to read the last Datagroup because its protected and we can't
                let errMsg = error.value
                ApplicationLogger.shared.Error("ERROR - \(errMsg)")

                var redoBAC = false
                if errMsg == "Session invalidated" || errMsg == "Class not supported" || errMsg == "Tag connection lost" {
                    throw error
                } else if errMsg == "Security status not satisfied" || errMsg == "File not found" {
                    // Can't read this element as we aren't allowed - remove it and return out so we re-do BAC
                    self.dataGroupsToRead.removeFirst()
                    redoBAC = true
                } else if errMsg == "SM data objects incorrect" || errMsg == "Class not supported" {
                    // Can't read this element security objects now invalid - and return out so we re-do BAC
                    redoBAC = true
                } else if errMsg.hasPrefix("Wrong length") || errMsg.hasPrefix("End of file") { // Should now handle errors 0x6C xx, and 0x67 0x00
                    // OK passport can't handle max length so drop it down
                    tagReader.reduceDataReadingAmount()
                    redoBAC = true
                }

                if redoBAC {
                    // Redo BAC and try again
                    try await doBACAuthentication(tagReader: tagReader)
                } else {
                    // Some other error lets have another try
                }
            }
            readAttempts += 1
        } while readAttempts < 2

        return nil
    }

    public func invalidateSession(errorMessage: NFCDisplayMessage, error: NfcDocumentReaderError) {
        // Mark the next 'invalid session' error as not reportable (we're about to cause it by invalidating the
        // session). The real error is reported back with the call to the completed handler
        shouldNotReportNextReaderSessionInvalidationErrorUserCanceled = true
        let errorMessage = displayMessageProvider.message(for: errorMessage)
        readerSession?.invalidate(errorMessage: errorMessage)

        nfcContinuation?.resume(throwing: error)
        nfcContinuation = nil
    }
}
