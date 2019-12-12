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

    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> MatcherResult? {
        var document = CDocumentInfo(
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1,
            orientation: Int32(orientation.rawValue)
        )
        RecogLib_iOS.verify(cppObject, buffer, &document)
        return MatcherResult(document: document)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> MatcherResult? {
        var document = CDocumentInfo(
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1,
            orientation: Int32(orientation.rawValue)
        )
        RecogLib_iOS.verifyImage(cppObject, imageBuffer, &document)
        return MatcherResult(document: document)
    }
}
