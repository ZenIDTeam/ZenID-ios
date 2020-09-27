//
//  FaceLivenessVerifier.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 19/05/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation
import CoreMedia

public class FaceLivenessVerifier {
    fileprivate var cppObject: UnsafeRawPointer?
    
    private let modelsRelativePath = "face"
    private let modelContentFile = "lbfmodel.yaml.bin"

    public var language: SupportedLanguages
    
    public var showDebugInfo: Bool = false {
        didSet {
            setFaceLivenessDebugInfo(cppObject, showDebugInfo)
        }
    }
        
    public init(language: SupportedLanguages) {
        self.language = language
        
        createFaceLivenessVerifier()
    }
    
    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceLivenessResult? {
        var face = createFaceLivenessInfo(orientation: orientation)
        RecogLib_iOS.verifyFaceLiveness(cppObject, buffer, &face)
        return FaceLivenessResult(faceLivenessStage: face.stage)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceLivenessResult? {
        var face = createFaceLivenessInfo(orientation: orientation)
        RecogLib_iOS.verifyFaceLivenessImage(cppObject, imageBuffer, &face)
        return FaceLivenessResult(faceLivenessStage: face.stage)
    }
    
    public func reset() {
        RecogLib_iOS.faceLivenessVerifierReset(cppObject)
    }
    
    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var face = createFaceLivenessInfo(orientation: orientation)
        let cString = RecogLib_iOS.getFaceLivenessRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &face)
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
    
    private func createFaceLivenessVerifier() {
        let modelFolderURL = Bundle(for: FaceLivenessVerifier.self)
            .bundleURL
            .appendingPathComponent(modelsRelativePath)
        
        let model = readModel(modelFolderURL)
        model.withUnsafeBytes {
            if let typedPtr = $0.bindMemory(to: CChar.self).baseAddress {
                self.cppObject = RecogLib_iOS.getFaceLivenessVerifier(modelFolderURL.path.toUnsafeMutablePointer()!, typedPtr, model.count)
            }
        }
    }

    private func readModel(_ folderURL: URL) -> Data {
        let fileURL = folderURL.appendingPathComponent(modelContentFile)
        
        if let handle = try? FileHandle(forReadingFrom: fileURL) {
            defer { handle.closeFile() }
            
            let data = handle.readDataToEndOfFile()
            NSLog("Loaded model: \(fileURL.lastPathComponent)")
            return data
        }
        
        return Data()
    }
    
    private func createFaceLivenessInfo(orientation: UIInterfaceOrientation) -> CFaceLivenessInfo {
        return CFaceLivenessInfo(
            stage: -1,
            orientation: Int32(orientation.rawValue),
            language: Int32(language.rawValue)
        )
    }
}
