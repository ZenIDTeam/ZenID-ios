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

    // TODO: improve framework path
    private let modelsRelativePath = "/Frameworks/RecogLib_iOS.framework"

    public var documentRole: DocumentRole
    public var country: Country
    public var page: PageCode

    public init(role: DocumentRole, country: Country, page: PageCode) {
        let modelsPath = Bundle.main.bundlePath + modelsRelativePath
        self.cppObject = loadWrapper(modelsPath.cString(using: .utf8))
        self.documentRole = role
        self.country = country
        self.page = page
    }

    public func verify(buffer: CMSampleBuffer) -> MatcherResult? {
        var document = CDocumentInfo(
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1
        )
        RecogLib_iOS.verify(cppObject, buffer, &document, 0, 0)
        return MatcherResult(document: document)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, displayWidth: Double, displayHeight: Double, frameWidth: Double, frameHeight: Double) -> MatcherResult? {
        var document = CDocumentInfo(
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1
        )
        let alignments = margins(from: displayWidth, displayHeight: displayHeight, frameWidth: frameWidth, frameHeight: frameHeight);
        RecogLib_iOS.verifyImage(cppObject, imageBuffer, &document, alignments.horizontal, alignments.vertical)
        return MatcherResult(document: document)
    }

    public func verify(buffer: CMSampleBuffer, displayWidth: Double, displayHeight: Double, frameWidth: Double, frameHeight: Double) -> MatcherResult? {
        var document = CDocumentInfo(
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1
        )
        let alignments = margins(from: displayWidth, displayHeight: displayHeight, frameWidth: frameWidth, frameHeight: frameHeight);
        RecogLib_iOS.verify(cppObject, buffer, &document, alignments.horizontal, alignments.vertical)
        return MatcherResult(document: document)
    }

    func margins(from displayWidth: Double, displayHeight: Double, frameWidth: Double, frameHeight: Double) -> (horizontal: Float, vertical: Float) {
        
        let horizontal = (1 - frameWidth / displayWidth) / 2
        let vertical = (1 - frameHeight / displayHeight) / 2
        
        return (Float(horizontal), Float(vertical))
    }
}
