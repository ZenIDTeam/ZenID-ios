//
//  CDocumentWrapper.cpp
//  RecogLib-iOS
//
//  Created by Marek Stana on 26/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#include "include/CDocumentWrapper.hpp"
#include "./include/ZenidEnums.generated.h"
#include "./include/DocumentPictureVerifier.h"

#include "opencv2/opencv.hpp"

#include <CoreMedia/CoreMedia.h>

#include <string>

const void * loadWrapper(const char *path)
{
    RecogLibC::DocumentPictureVerifier *verifier = new RecogLibC::DocumentPictureVerifier(path);
    printf("[DEBUG-DOCUMENT] created!");
    return (void *)verifier;
}

bool verify(const void *object,
            CMSampleBufferRef _mat,
            CMatcherResult* result,
            float _horizontalMargin,
            float _verticalMargin,
            int _documentRole,
            int _country,
            int _pageCode)
{
    RecogLibC::DocumentPictureVerifier *verifier = (RecogLibC::DocumentPictureVerifier *)object;

    float verticalMargin = _verticalMargin;
    float horizontalMargin = _horizontalMargin;

    // Construct outline
    const std::array<cv::Point2f, 4> expectedOutline {
        {
            {horizontalMargin, verticalMargin},
            {1.f - horizontalMargin, verticalMargin},
            {1.f - horizontalMargin, 1.f - verticalMargin},
            {horizontalMargin, 1.f - verticalMargin},
        }
    };

    // Construct optional data
    auto documentRole = static_cast<RecogLibC::DocumentRole>(_documentRole);
    auto country = static_cast<RecogLibC::Country>(_country);
    auto pageCode = static_cast<RecogLibC::PageCodes>(_pageCode);

//    printf("[DEBUG-DOCUMENT-CONVERT] starts");

    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    CVPixelBufferLockBaseAddress( cvBuffer, 0 );
    int widht = (int)CVPixelBufferGetWidth(cvBuffer);
    int height = (int)CVPixelBufferGetHeight(cvBuffer);
    int bytesPerRow = (int)CVPixelBufferGetBytesPerRow(cvBuffer);
    printf("[DEBUG-DOCUMENT-CONVERT] ends\n");

    printf("[DEBUG-DOCUMENT-VERIFY] start\n");

    OSType format = CVPixelBufferGetPixelFormatType(cvBuffer);

    cv::Mat image;
    if (format == kCVPixelFormatType_32BGRA) {
        image = cv::Mat(height, widht, CV_8UC4, CVPixelBufferGetBaseAddress(cvBuffer), 0);
//    } else if (format == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
//        image = cv::Mat(height, widht, CV_8UC1, CVPixelBufferGetBaseAddress(cvBuffer), bytesPerRow);
    } else {
        assert(false);
        printf("Unsupported format for CVPixelBufferGetPixelFormatType");
    }
    //    printf("[DEBUG-DOCUMENT-CONVERT] ends");

    //    printf("[DEBUG-DOCUMENT-VERIFY] start");
    verifier->ProcessFrame(image, expectedOutline, documentRole, country, pageCode);

    CVPixelBufferUnlockBaseAddress( cvBuffer, 0 );

    const auto state = verifier->GetState();
    auto _state = static_cast<int>(state);

    printf("[DEBUG-DOCUMENT-VERIFY] verifier state: %i\n", state);
    
    if (state == RecogLibC::DocumentPictureVerifier::State::NoMatchFound) {
        result->documentRole = 0;
        result->documentCode = 0;
        result->documentCountry = 0;
        result->documentCode = 0;
        result->state = _state;
        return false;
    }
    
    const auto documentCode = verifier->GetDocumentCode();
    auto _documentCode = static_cast<int>(documentCode);
    
    result->documentRole = _documentRole;
    result->documentCode = _documentCode;
    result->documentCountry = _country;
    result->documentCode = _pageCode;
    result->state = _state;
    
    return true;
}
