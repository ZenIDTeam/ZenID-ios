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

    private var isLoaded = false
    fileprivate var cppObject: UnsafeRawPointer?

    public init() {
    }

    public func load() {
        if !isLoaded {
            let modelsPath = Bundle.main.bundlePath + "/Frameworks/RecogLib_iOS.framework/models"
            self.cppObject = loadWrapper((modelsPath as NSString).utf8String)
        }
        // load documents
        isLoaded = true
        print("loaded")
    }

    public func verify() {
        print("[DEBUG] verifying: ")
        print(RecogLib_iOS.verify(cppObject, 0, 0, 0, 0, 0, 0))
        print("[DEBUG] verifying ended")
    }

    func parseBuffer(buffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else {
            return
        }

        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)


        let mat =
        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
//        - (void) parseBuffer:(CMSampleBufferRef) sampleBuffer
//        {
//            CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
//            CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
//            //Processing here
//            int bufferWidth = CVPixelBufferGetWidth(pixelBuffer);
//            int bufferHeight = CVPixelBufferGetHeight(pixelBuffer);
//            unsigned char *pixel = (unsigned char *)CVPixelBufferGetBaseAddress(pixelBuffer);
//            // put buffer in open cv, no memory copied
//            cv::Mat mat = cv::Mat(bufferHeight,bufferWidth,CV_8UC4,pixel);
//            //End processing
//            CVPixelBufferUnlockBaseAddress( pixelBuffer, 0 );
//        }
    }
}
