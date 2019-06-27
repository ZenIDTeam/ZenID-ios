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
    private let frameworkPath = "/Frameworks/RecogLib_iOS.framework/models"

    public var document: DocumentRole!
    private var country: Country!
    private var page: PageCode!

    public init() {
        let modelsPath = Bundle.main.bundlePath + frameworkPath
        self.cppObject = loadWrapper((modelsPath as NSString).utf8String)
    }

    public func configure(document: DocumentRole, country: Country, page: PageCode) {
        self.document = document
        self.country = country
        self.page = page
    }

    public func verify(buffer: CMSampleBuffer) -> MatcherResult? {
        let result = RecogLib_iOS.verify(cppObject, buffer, 0, 0, Int32(document.rawValue), Int32(country.rawValue), Int32(page.rawValue))
        return MatcherResult(result: result)
    }

    public func verify(buffer: CMSampleBuffer, displayWidth: Double, displayHeight: Double, frameHeight: Double) -> MatcherResult? {
        let aligments = margins(from: displayWidth, displayHeight: displayHeight, frameHeight: frameHeight);
        return MatcherResult(result: RecogLib_iOS.verify(cppObject, buffer, aligments.horizontal, aligments.vertical, Int32(document.rawValue), Int32(country.rawValue), Int32(page.rawValue)))
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
