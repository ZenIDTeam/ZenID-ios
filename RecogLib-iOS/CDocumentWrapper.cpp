//
//  CDocumentWrapper.cpp
//  RecogLib-iOS
//
//  Created by Marek Stana on 26/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#include "CDocumentWrapper.hpp"
#include "RecogLibC.h"

#include "opencv2/opencv.hpp"

#include <CoreMedia/CoreMedia.h>

#include <string>

#define DEBUG_PRINT_ENABLED 0 // set to 1 to enable logging

using namespace RecogLibC;

const void * loadWrapper(const char *path)
{
    RecogLibC::DocumentPictureVerifier *verifier = new RecogLibC::DocumentPictureVerifier(path);
    printf("[Recoglib] loaded!");
    return (void *)verifier;
}

Orientation getOrientation(int interfaceOrientation) {
    switch(interfaceOrientation) {
        case 0: // .unknown
        case 1: // .portrait
            return Orientation::Up;
        case 2: // .portraitUpsideDown
            return Orientation::Down;
        case 3: // .landscapeLeft
            return Orientation::Left; //TODO: Check correct orientation
        case 4: // .landscapeRight
            return Orientation::Right; //TODO: Check correct orientation
        default:
            return Orientation::Up;
    }
}

bool verify(
    const void *object,
    CMSampleBufferRef _mat,
    CDocumentInfo *document
)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyImage(object, cvBuffer, document);
}

bool verifyImage(
            const void *object,
            CVPixelBufferRef _cvBuffer,
            CDocumentInfo *document
            )
{
    DocumentPictureVerifier *verifier = (DocumentPictureVerifier *)object;

    // Construct optional data
    auto documentRole = static_cast<DocumentRole>(document->role);
    auto country = static_cast<Country>(document->country);
    auto pageCode = static_cast<PageCodes>(document->page);
    
#if DEBUG_PRINT_ENABLED
    printf("[DEBUG-Recoglib-CONVERT] starts");
#endif
    CVPixelBufferLockBaseAddress( _cvBuffer, 0 );
    const int widht = (int)CVPixelBufferGetWidth(_cvBuffer);
    const int height = (int)CVPixelBufferGetHeight(_cvBuffer);
    
#if DEBUG_PRINT_ENABLED
    printf("[DEBUG-Recoglib-CONVERT] ends\n");
#endif
    
#if DEBUG_PRINT_ENABLED
    printf("[DEBUG-Recoglib-VERIFY] start\n");
#endif
    
    OSType format = CVPixelBufferGetPixelFormatType(_cvBuffer);
        
    if (format != kCVPixelFormatType_32BGRA) {
        printf("Unsupported format for CVPixelBufferGetPixelFormatType");
        assert(false);
    }
    
    void *data = CVPixelBufferGetBaseAddress(_cvBuffer);
    Image image(data, widht, height, ImageFormat::BGRA, ImageDataType::UInt8);
    
#if DEBUG_PRINT_ENABLED
    printf("[DEBUG-Recoglib-CONVERT] ends");
#endif
#if DEBUG_PRINT_ENABLED
    printf("[DEBUG-Recoglib-VERIFY] start");
#endif
    verifier->ProcessFrame(image,
                           getOrientation(document->orientation),
                           &documentRole,
                           &country,
                           &pageCode,
                           nullptr);
    
    CVPixelBufferUnlockBaseAddress( _cvBuffer, 0 );
    
    const auto state = verifier->GetState();
    
    if (state == RecogLibC::DocumentPictureVerifier::State::NoMatchFound) {
        document->code = -1;
        document->state = static_cast<int>(state);
        return false;
    }
    
    document->code = static_cast<int>(verifier->GetDocumentCode());
    document->page = static_cast<int>(verifier->GetPageCode());
    document->state = static_cast<int>(state);
    
    return true;
}
