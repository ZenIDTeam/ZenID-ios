//
//  FaceLivenessWrapper.cpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 19/05/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

#include "CUtils.hpp"
#include "CFaceLivenessWrapper.hpp"
#include "RecogLibC.h"
#include "opencv2/opencv.hpp"
#include <CoreMedia/CoreMedia.h>
#include <string>

using namespace RecogLibC;

const void * getFaceLivenessVerifier(const char* resourcesPath,
                             const char* lbfModelContents,
                             size_t lbfModelSize)
{
    FaceLivenessVerifier *verifier = new FaceLivenessVerifier(resourcesPath, lbfModelContents, lbfModelSize);
    return (void *)verifier;
}

bool verifyFaceLiveness(const void *object,
                CMSampleBufferRef _mat,
                CFaceLivenessInfo *face)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyFaceLivenessImage(object, cvBuffer, face);
}

bool verifyFaceLivenessImage(const void *object,
                     CVPixelBufferRef _cvBuffer,
                     CFaceLivenessInfo *face)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    
    CVPixelBufferLockBaseAddress(_cvBuffer, 0);
    const int widht = (int)CVPixelBufferGetWidth(_cvBuffer);
    const int height = (int)CVPixelBufferGetHeight(_cvBuffer);
    const int stride = (int)CVPixelBufferGetBytesPerRow(_cvBuffer);
    
    OSType format = CVPixelBufferGetPixelFormatType(_cvBuffer);
    
    if (format != kCVPixelFormatType_32BGRA) {
        throw std::runtime_error(std::string("Unsupported format for CVPixelBufferGetPixelFormatType"));
    }
    
    void *data = CVPixelBufferGetBaseAddress(_cvBuffer);
    Image image(data, widht, height, ImageFormat::BGRA, stride);
    image.Rotate(RotateFlags::Rotate90Clockwise);
    image.FlipHorizontally();
    
    verifier->ProcessFrame(image);
    
    CVPixelBufferUnlockBaseAddress(_cvBuffer, 0 );
    
    const auto state = verifier->GetStage();
    
    if (state == FaceLivenessVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = verifier->GetSignature().size();
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = verifier->GetSignedImage().size();
        face->signature = signature;
    }
    
    if (state != RecogLibC::FaceLivenessVerifierState::Ok) {
        face->state = static_cast<int>(state);
        return false;
    }

    face->state = static_cast<int>(state);
    return true;
}

void faceLivenessVerifierReset(const void *object)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    verifier->Reset();
}

char* getFaceLivenessRenderCommands(const void *object,
                            int canvasWidth,
                            int canvasHeight,
                            CFaceLivenessInfo *face)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    
    auto language = static_cast<SupportedLanguages>(face->language);
    
    std::string renderString = verifier->GetRenderCommands(canvasWidth, canvasHeight, language);
    return getString(renderString);
}

void setFaceLivenessDebugInfo(const void *object,
                       bool show)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    verifier->SetDebugVisualization(show);
}
