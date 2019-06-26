//
//  DocumentVerifier.swift
//  RecogLib-iOS
//
//  Created by Marek Stana on 25/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation


public class DocumentVerifier {

    private var isLoaded = false
    fileprivate var cppObject: UnsafeRawPointer?

    public init() {
    }

    public func load() {
        if !isLoaded {
            let modelsPath = Bundle.main.bundlePath + "/Frameworks/RecogLib_iOS.framework/models"
            self.cppObject = initializeListWrapper((modelsPath as NSString).utf8String)
        }
        // load documents
        isLoaded = true
        print("loaded")
    }

    public func verify() {
        print("verified")
    }
}
