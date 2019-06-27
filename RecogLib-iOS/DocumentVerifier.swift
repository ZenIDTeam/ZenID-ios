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

    public init() {
        let modelsPath = Bundle.main.bundlePath + "/Frameworks/RecogLib_iOS.framework/models"
        self.cppObject = loadWrapper((modelsPath as NSString).utf8String)
    }

    public func verify(buffer: CMSampleBuffer) -> MatcherResult? {
        return MatcherResult(result: RecogLib_iOS.verify(cppObject, buffer, 0, 0, Int32(DocumentRole.Idc.rawValue), Int32(Country.Cz.rawValue), Int32(PageCodes.F.rawValue)))
    }

    public func verify(buffer: CMSampleBuffer, displayWidth: Double, displayHeight: Double, frameHeight: Double) -> MatcherResult? {
        let aligments = margins(from: displayWidth, displayHeight: displayHeight, frameHeight: frameHeight);
        return MatcherResult(result: RecogLib_iOS.verify(cppObject, buffer, aligments.horizontal, aligments.vertical, Int32(DocumentRole.Idc.rawValue), Int32(Country.Cz.rawValue), Int32(PageCodes.F.rawValue)))
    }

    private func margins(from displayWidth: Double, displayHeight: Double, frameHeight: Double) -> (horizontal: Float, vertical: Float) {

        let frameWidth = frameHeight * 1.585 // Rozměr občanky je 85,6 x 54, to jest 1.585 ku 1.0
        let framePercentageWidth = (frameWidth * 100) / displayWidth
        let framePercentageHeight = (frameHeight * 100) / displayHeight

        let horizontal = (100 - framePercentageWidth) / 2 / 100
        let vertical = (100 - framePercentageHeight) / 2 / 100

        return (Float(horizontal), Float(vertical))
    }
}
