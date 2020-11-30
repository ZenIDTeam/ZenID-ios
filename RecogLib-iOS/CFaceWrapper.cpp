//
//  FaceDetectorWrapper.cpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 19/05/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

#include "CUtils.hpp"
#include "CFaceWrapper.hpp"
#include "RecogLibC.h"
#include "opencv2/opencv.hpp"
#include <CoreMedia/CoreMedia.h>
#include <string>

using namespace RecogLibC;

const void * getFaceVerifier(const char* resourcesPath,
                             const char* lbfModelContents,
                             size_t lbfModelSize)
{
    FaceLivenessVerifier *verifier = new FaceLivenessVerifier(resourcesPath, lbfModelContents, lbfModelSize);
    return (void *)verifier;
}

bool verifyFace(const void *object,
                CMSampleBufferRef _mat,
                CFaceInfo *face)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyFaceImage(object, cvBuffer, face);
}

bool verifyFaceImage(const void *object,
                     CVPixelBufferRef _cvBuffer,
                     CFaceInfo *face)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    
    CVPixelBufferLockBaseAddress(_cvBuffer, 0);
    const int widht = (int)CVPixelBufferGetWidth(_cvBuffer);
    const int height = (int)CVPixelBufferGetHeight(_cvBuffer);
    
    OSType format = CVPixelBufferGetPixelFormatType(_cvBuffer);
    
    if (format != kCVPixelFormatType_32BGRA) {
        printf("Unsupported format for CVPixelBufferGetPixelFormatType");
        assert(false);
    }
    
    void *data = CVPixelBufferGetBaseAddress(_cvBuffer);
    Image image(data, widht, height, ImageFormat::BGRA);
    
    verifier->ProcessFrame(image);
    
    CVPixelBufferUnlockBaseAddress( _cvBuffer, 0 );
    
    const auto stage = verifier->GetStage();
    
    if (stage != RecogLibC::FaceLivenessVerifier::Stage::Done) {
        face->stage = static_cast<int>(stage);
        return false;
    }

    face->stage = static_cast<int>(stage);
    return true;
}

void faceVerifierReset(const void *object)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    verifier->Reset();
}

char* getFaceRenderCommands(const void *object,
                            int canvasWidth,
                            int canvasHeight,
                            CFaceInfo *face)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    
    auto language = static_cast<SupportedLanguages>(face->language);
    
    auto canvasSize = cv::Size(canvasWidth, canvasHeight);
    std::string renderString = verifier->GetRenderCommands(canvasSize, language);
    return getString(renderString);
}

void setFaceDebugInfo(const void *object,
                       bool show)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    verifier->SetDebugVisualization(show);
}
