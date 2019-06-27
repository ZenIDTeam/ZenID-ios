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
    printf("[DEBUG-DOCUMENT-VERIFY] horizontalMargin: %f, verticalMargin: %f", horizontalMargin, verticalMargin);


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
    printf("[DEBUG-DOCUMENT-VERIFY] documentRole: %i, pageCode: %i, country: %i", (int) documentRole, (int) pageCode, (int) country);

    // Construct image

    printf("[DEBUG-DOCUMENT-CONVERT] starts");
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    CVPixelBufferLockBaseAddress( cvBuffer, 0 );
    int widht = (int)CVPixelBufferGetWidth(cvBuffer);
    int height = (int)CVPixelBufferGetHeight(cvBuffer);
    int bytesPerRow = (int)CVPixelBufferGetBytesPerRow(cvBuffer);
    cv::Mat image(height, widht, CV_8UC4, CVPixelBufferGetBaseAddress(cvBuffer), bytesPerRow);
    CVPixelBufferUnlockBaseAddress( cvBuffer, 0 );
    printf("[DEBUG-DOCUMENT-CONVERT] ends");

    printf("[DEBUG-DOCUMENT-VERIFY] start");
    verifier->ProcessFrame(image, expectedOutline, documentRole, country, pageCode);

    const auto state = verifier->GetState();

    printf("[DEBUG-DOCUMENT-VERIFY] verifier state: %i", state);

    const auto documentCode = static_cast<int>(verifier->GetDocumentCode());
    auto _state = static_cast<int>(state);
    
    result->documentRole = _documentRole;
    result->documentCountry = _country;
    result->documentCode = _pageCode;
    result->state = _state;
    result->documentCode = documentCode;
    
    return true;
}
