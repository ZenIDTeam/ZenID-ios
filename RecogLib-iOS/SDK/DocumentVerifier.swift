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

    public var documentRole: DocumentRole
    public var country: Country
    public var page: PageCode
    public var language: SupportedLanguages
    
    public var showDebugInfo: Bool = false {
        didSet {
            setDocumentDebugInfo(cppObject, showDebugInfo)
        }
    }

    public init(role: DocumentRole, country: Country, page: PageCode, language: SupportedLanguages) {
        self.documentRole = role
        self.country = country
        self.page = page
        self.language = language
        
        self.cppObject = getDocumentVerifier()
        let modelsURL = Bundle(for: DocumentVerifier.self)
            .bundleURL
            .appendingPathComponent(modelsRelativePath)
        listModels(modelsURL).forEach(readModel(url:))
    }

    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.verify(cppObject, buffer, &document)
        return DocumentResult(document: document)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.verifyImage(cppObject, imageBuffer, &document)
        return DocumentResult(document: document)
    }
    
    public func verifyHologram(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> HologramResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.verifyHologram(cppObject, buffer, &document)
        return HologramResult(document: document)
    }
    
    public func verifyHologramImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> HologramResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.verifyHologramImage(cppObject, imageBuffer, &document)
        return HologramResult(document: document)
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
        //RecogLib_iOS.reset(cppObject)
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
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1,
            hologramState: -1,
            orientation: Int32(orientation.rawValue)
        )
    }
    
    private func readModel(url: URL) {
        if let handle = try? FileHandle(forReadingFrom: url) {
            defer { handle.closeFile() }
            
            let data = handle.readDataToEndOfFile()
            data.withUnsafeBytes {
                if let typedPtr = $0.bindMemory(to: CChar.self).baseAddress {
                    RecogLib_iOS.loadModel(self.cppObject, typedPtr, data.count)
                    NSLog("Loaded model: \(url.lastPathComponent)")
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
