//
//  FaceDetector.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 19/05/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation
import CoreMedia

public class FaceVerifier {
    fileprivate var cppObject: UnsafeRawPointer?
    
    private let modelsRelativePath = "models"
    private let haarcascadesRelativePath = "haarcascades"
    private let modelContentFile = "lbfmodel.yaml.bin"
    
    public var language: SupportedLanguages
    
    public var showDebugInfo: Bool = false {
        didSet {
            setFaceDebugInfo(cppObject, showDebugInfo)
        }
    }
        
    public init(language: SupportedLanguages) {
        self.language = language
        
        createFaceVerifier()
    }
    
    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceResult? {
        var face = createFaceInfo(orientation: orientation)
        RecogLib_iOS.verifyFace(cppObject, buffer, &face)
        return FaceResult(faceStage: face.stage)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceResult? {
        var face = createFaceInfo(orientation: orientation)
        RecogLib_iOS.verifyFaceImage(cppObject, imageBuffer, &face)
        return FaceResult(faceStage: face.stage)
    }
    
    public func reset() {
        RecogLib_iOS.faceVerifierReset(cppObject)
    }
    
    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var face = createFaceInfo(orientation: orientation)
        let cString = RecogLib_iOS.getFaceRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &face)
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
    
    private func createFaceVerifier() {
        let modelFolderURL = Bundle(for: FaceVerifier.self)
            .bundleURL
            .appendingPathComponent(modelsRelativePath)
        let resourcesPath = Bundle(for: FaceVerifier.self)
            .bundleURL
            .appendingPathComponent(haarcascadesRelativePath)
            .path
        
        let model = readModel(modelFolderURL)
        model.withUnsafeBytes {
            if let typedPtr = $0.bindMemory(to: CChar.self).baseAddress {
                self.cppObject = getFaceVerifier(resourcesPath.toUnsafeMutablePointer()!, typedPtr, model.count)
            }
        }
    }
    
    private func createFaceInfo(orientation: UIInterfaceOrientation) -> CFaceInfo {
        return CFaceInfo(
            stage: -1,
            orientation: Int32(orientation.rawValue),
            language: Int32(language.rawValue)
        )
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
}
