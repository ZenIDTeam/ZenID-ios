//
//  DocumentVerifier.swift
//  RecogLib-iOS
//
//  Created by Marek Stana on 25/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation
import CoreMedia

public class DocumentVerifier {
    fileprivate var cppObject: UnsafeRawPointer?

    private let modelsRelativePath = "documents"
    private let modelPrefix = "recoglibc"
    private let modelSuffix = "bin"
    
    public var documentRole: DocumentRole?
    public var country: Country?
    public var page: PageCode?
    public var code: DocumentCode?
    public let settings: DocumentVerifierSettings?
    
    public var acceptableInputJson: String?
    
    public var language: SupportedLanguages
    
    public var showDebugInfo: Bool = false {
        didSet {
            setDocumentDebugInfo(cppObject, showDebugInfo)
        }
    }

    public init(role: DocumentRole?, country: Country?, page: PageCode?, code: DocumentCode?, language: SupportedLanguages, settings: DocumentVerifierSettings? = nil) {
        self.documentRole = role
        self.country = country
        self.page = page
        self.code = code
        self.language = language
        self.settings = settings
        
        var verifierSettings = createDocumentVerifierSettings(settings: settings)
        self.cppObject = getDocumentVerifier(&verifierSettings)
        let modelsURL = Bundle(for: DocumentVerifier.self)
            .bundleURL
            .appendingPathComponent(modelsRelativePath)
        listModels(modelsURL).forEach(readModel(url:))
    }
    
    public init(input: DocumentsInput, language: SupportedLanguages, settings: DocumentVerifierSettings? = nil) {
        self.acceptableInputJson = input.acceptableInputJson()
        self.language = language
        self.settings = settings
        
        var verifierSettings = createDocumentVerifierSettings(settings: settings)
        self.cppObject = getDocumentVerifier(&verifierSettings)
        let modelsURL = Bundle(for: DocumentVerifier.self)
            .bundleURL
            .appendingPathComponent(modelsRelativePath)
        listModels(modelsURL).forEach(readModel(url:))
    }

    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        do {
            var document = createDocumentInfo(orientation: orientation)
            RecogLib_iOS.verify(cppObject, buffer, &document, acceptableInputJson?.toUnsafeMutablePointer())
            return DocumentResult(document: document)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        do {
            var document = createDocumentInfo(orientation: orientation)
            RecogLib_iOS.verifyImage(cppObject, imageBuffer, &document, acceptableInputJson?.toUnsafeMutablePointer())
            return DocumentResult(document: document)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func verifyHologram(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> HologramResult? {
        do {
            var document = createDocumentInfo(orientation: orientation)
            RecogLib_iOS.verifyHologram(cppObject, buffer, &document)
            return HologramResult(document: document)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func verifyHologramImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> HologramResult? {
        do {
            var document = createDocumentInfo(orientation: orientation)
            RecogLib_iOS.verifyHologramImage(cppObject, imageBuffer, &document)
            return HologramResult(document: document)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func supportsHologram() -> Bool {
        return RecogLib_iOS.supportsHologram(cppObject)
    }
    
    public func beginHologramVerification() {
        RecogLib_iOS.beginHologramVerification(cppObject)
    }

    public func endHologramVerification() {
        RecogLib_iOS.endHologramVerification(cppObject)
    }
    
    public func reset() {
        RecogLib_iOS.reset(cppObject)
    }
    
    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var document = createDocumentInfo(orientation: orientation)
        let cString = RecogLib_iOS.getDocumentRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &document)
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
    
    private func createDocumentInfo(orientation: UIInterfaceOrientation) -> CDocumentInfo {
        return CDocumentInfo(
            language: Int32(language.rawValue),
            role: documentRole == nil ? -1 : Int32(documentRole!.rawValue),
            country: country == nil ? -1 : Int32(country!.rawValue),
            code: code == nil ? -1 : Int32(code!.rawValue),
            page: page == nil ? -1 : Int32(page!.rawValue),
            state: -1,
            hologramState: -1,
            orientation: Int32(orientation.rawValue)
        )
    }
    
    private func createDocumentVerifierSettings(settings: DocumentVerifierSettings?) -> CDocumentVerifierSettings {
        return CDocumentVerifierSettings(
            specularAcceptableScore: Int32(settings?.specularAcceptableScore ?? 50),
            documentBlurAcceptableScore: Int32(settings?.documentBlurAcceptableScore ?? 50),
            timeToBlurMaxToleranceInSeconds: Int32(settings?.timeToBlurMaxToleranceInSeconds ?? 10)
        )
    }
    
    private func readModel(url: URL) {
        if let handle = try? FileHandle(forReadingFrom: url) {
            defer { handle.closeFile() }
            
            let data = handle.readDataToEndOfFile()
            data.withUnsafeBytes {
                if let typedPtr = $0.bindMemory(to: CChar.self).baseAddress {
                    RecogLib_iOS.loadModel(self.cppObject, typedPtr, data.count)
                    ApplicationLogger.shared.Info("Loaded model: \(url.lastPathComponent)")
                }
            }
        }
    }
    
    private func listModels(_ folderURL: URL) -> [URL] {
        if let contents = try? FileManager.default.contentsOfDirectory(atPath: folderURL.path) {
            return contents
                .filter { $0.hasSuffix(modelSuffix) && $0.hasPrefix(modelPrefix) }
                .sorted()
                .map(folderURL.appendingPathComponent)
        }
        else {
            return []
        }
    }
}
