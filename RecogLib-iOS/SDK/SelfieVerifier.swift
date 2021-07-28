//
//  SelfieVerifier.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 23/09/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

import Foundation
import CoreMedia

public class SelfieVerifier {
    fileprivate var cppObject: UnsafeRawPointer?
    
    private let modelsRelativePath = "face"
    private let modelContentFile = "haarcascade_frontalface_alt2.xml"
    
    public var language: SupportedLanguages
    
    public var showDebugInfo: Bool = false {
        didSet {
            setSelfieDebugInfo(cppObject, showDebugInfo)
        }
    }
        
    public init(language: SupportedLanguages) {
        self.language = language
        
        createSelfieVerifier()
    }
    
    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> SelfieResult? {
        do {
            var selfie = createSelfieInfo(orientation: orientation)
            RecogLib_iOS.verifySelfie(cppObject, buffer, &selfie)
            return SelfieResult(selfieState: selfie.state, signature: selfie.signature)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> SelfieResult? {
        do {
            var selfie = createSelfieInfo(orientation: orientation)
            RecogLib_iOS.verifySelfieImage(cppObject, imageBuffer, &selfie)
            return SelfieResult(selfieState: selfie.state, signature: selfie.signature)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func reset() {
        RecogLib_iOS.selfieVerifierReset(cppObject)
    }
    
    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var selfie = createSelfieInfo(orientation: orientation)
        let cString = RecogLib_iOS.getSelfieRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &selfie)
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }

    private func createSelfieVerifier() {
        let modelFolderURL = Bundle(for: SelfieVerifier.self)
            .bundleURL
            .appendingPathComponent(modelsRelativePath)
            .appendingPathComponent(modelContentFile)
        
        self.cppObject = RecogLib_iOS.getSelfieVerifier()
        RecogLib_iOS.loadSelfie(cppObject, modelFolderURL.path.toUnsafeMutablePointer()!)
    }
    
    private func createSelfieInfo(orientation: UIInterfaceOrientation) -> CSelfieInfo {
        return CSelfieInfo(
            state: -1,
            orientation: Int32(orientation.rawValue),
            language: Int32(language.rawValue),
            signature: .init()
        )
    }
}
