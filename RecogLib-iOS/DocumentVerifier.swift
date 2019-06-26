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

    public init() {

//        var myCppClass:OpaquePointer? = nil;
//
//        myCppClass = CreateCppClass();
//        CallHelloWorld(myCppClass);
//        ReleaseCppClass(myCppClass);

        load()
    }

    func load() {
        // load documents
        isLoaded = true
        
    }

    public func verify() {
        
        VerifyDocumentFromVideo()
        // logic behind verifing
    }
}
