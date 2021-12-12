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
    private var cppObject: UnsafeRawPointer?

    public var language: SupportedLanguages
    private let settings: FaceLivenessVerifierSettings?
    
    public var showDebugInfo: Bool = false {
        didSet {
            setFaceLivenessDebugInfo(cppObject, showDebugInfo)
        }
    }
        
    public init(language: SupportedLanguages, settings: FaceLivenessVerifierSettings? = nil) {
        self.language = language
        self.settings = settings
    }
    
    public func loadModels(_ loader: FaceVerifierModels) {
        loader.loadPointer { pointer, data in
            var verifierSettings = createVerifierSettings(settings: settings)
            cppObject = RecogLib_iOS.getFaceLivenessVerifier(loader.url.path.toUnsafeMutablePointer()!, &verifierSettings)
        }
    }
    
    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceLivenessResult? {
        do {
            var face = createFaceLivenessInfo(orientation: orientation)
            RecogLib_iOS.verifyFaceLiveness(cppObject, buffer, &face)
            return FaceLivenessResult(faceLivenessState: face.state, signature: face.signature)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceLivenessResult? {
        do {
            var face = createFaceLivenessInfo(orientation: orientation)
            RecogLib_iOS.verifyFaceLivenessImage(cppObject, imageBuffer, &face)
            return FaceLivenessResult(faceLivenessState: face.state, signature: face.signature)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
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
    
    private func createFaceLivenessInfo(orientation: UIInterfaceOrientation) -> CFaceLivenessInfo {
        return CFaceLivenessInfo(
            state: -1,
            orientation: Int32(orientation.rawValue),
            language: Int32(language.rawValue),
            signature: .init()
        )
    }
    
    private func createVerifierSettings(settings: FaceLivenessVerifierSettings?) -> CFaceLivenessVerifierSettings {
        return CFaceLivenessVerifierSettings(
            enableLegacyMode: settings?.isLegacyModeEnabled ?? false,
            maxAuxiliaryImageSize: Int32(settings?.maxAuxiliaryImageSize ?? 300)
        )
    }
}
