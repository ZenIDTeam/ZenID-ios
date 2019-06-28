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
    private let modelsRelativePath = "/Frameworks/RecogLib_iOS.framework/models"

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

    public func verify(buffer: CMSampleBuffer, displayWidth: Double, displayHeight: Double, frameHeight: Double) -> MatcherResult? {
        var document = CDocumentInfo(
            role: Int32(documentRole.rawValue),
            country: Int32(country.rawValue),
            code: -1,
            page: Int32(page.rawValue),
            state: -1
        )
        let aligments = margins(from: displayWidth, displayHeight: displayHeight, frameHeight: frameHeight);
        RecogLib_iOS.verify(cppObject, buffer, &document, aligments.horizontal, aligments.vertical)
        return MatcherResult(document: document)
    }

    private func margins(from displayWidth: Double, displayHeight: Double, frameHeight: Double) -> (horizontal: Float, vertical: Float) {
        let frameWidth = frameHeight * 1.585 // ID size is (85,6 x 54), it means 1.585:1.0
        let framePercentageWidth = (frameWidth * 100) / displayWidth
        let framePercentageHeight = (frameHeight * 100) / displayHeight

        let horizontal = (100 - framePercentageWidth) / 2 / 100
        let vertical = (100 - framePercentageHeight) / 2 / 100

        return (Float(horizontal), Float(vertical))
    }
}
