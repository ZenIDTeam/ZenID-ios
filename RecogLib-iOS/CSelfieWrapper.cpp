//
//  CSelfieWrapper.cpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 23/09/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

#include "CUtils.hpp"
#include "CSelfieWrapper.hpp"
#include "RecogLibC.h"
#include "opencv2/opencv.hpp"
#include <CoreMedia/CoreMedia.h>
#include <string>

using namespace RecogLibC;

const void * getSelfieVerifier()
{
    SelfieVerifier *verifier = new SelfieVerifier();
    return (void *)verifier;
}

void loadSelfie(const void *object,
                const char *modelPath)
{
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    verifier->Load(modelPath);
}

bool verifySelfie(const void *object,
                CMSampleBufferRef _mat,
                CSelfieInfo *selfie)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifySelfieImage(object, cvBuffer, selfie);
}

bool verifySelfieImage(const void *object,
                     CVPixelBufferRef _cvBuffer,
                     CSelfieInfo *selfie)
{
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    
    CVPixelBufferLockBaseAddress(_cvBuffer, 0);
    const int widht = (int)CVPixelBufferGetWidth(_cvBuffer);
    const int height = (int)CVPixelBufferGetHeight(_cvBuffer);
    const int stride = (int)CVPixelBufferGetBytesPerRow(_cvBuffer);
    
    OSType format = CVPixelBufferGetPixelFormatType(_cvBuffer);
    
    if (format != kCVPixelFormatType_32BGRA) {
        printf("Unsupported format for CVPixelBufferGetPixelFormatType");
        assert(false);
    }
    
    void *data = CVPixelBufferGetBaseAddress(_cvBuffer);
    Image image(data, widht, height, ImageFormat::BGRA, stride);
    image.Rotate(RotateFlags::Rotate90Clockwise);
    
    verifier->ProcessFrame(image);
    
    CVPixelBufferUnlockBaseAddress(_cvBuffer, 0 );
    
    const auto state = verifier->GetState();
    
    if (state != RecogLibC::SelfieVerifierState::Ok) {
        selfie->state = static_cast<int>(state);
        return false;
    }

    selfie->state = static_cast<int>(state);
    return true;
}

void selfieVerifierReset(const void *object)
{
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    verifier->Reset();
}

char* getSelfieRenderCommands(const void *object,
                            int canvasWidth,
                            int canvasHeight,
                            CSelfieInfo *selfie)
{
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    
    auto language = static_cast<SupportedLanguages>(selfie->language);
    
    std::string renderString = verifier->GetRenderCommands(canvasWidth, canvasHeight, language);
    return getString(renderString);
}

void setSelfieDebugInfo(const void *object,
                       bool show)
{
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    verifier->SetDebugVisualization(show);
}
