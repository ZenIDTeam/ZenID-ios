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
        var cresult = CMatcherResult(documentRole: -1, documentCountry: -1, documentCode: -1, documentPage: -1, state: -1)
        RecogLib_iOS.verify(cppObject, buffer, &cresult, 0.5, 0.5, 0, 0, 0)
        return MatcherResult(result: cresult)
    }
}
