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
#include <CoreMedia/CoreMedia.h>
#include <string>

using namespace RecogLibC;

const void * getFaceLivenessVerifier(const char* resourcesPath, CFaceLivenessVerifierSettings *settings)
{
    FaceLivenessVerifierSettings verifierSettings = FaceLivenessVerifierSettings();
    verifierSettings.enableLegacyMode = settings->enableLegacyMode;
    verifierSettings.maxAuxiliaryImageSize = settings->maxAuxiliaryImageSize;
    FaceLivenessVerifier *verifier = new FaceLivenessVerifier(resourcesPath, std::make_shared<FaceLivenessVerifierSettings>(verifierSettings));
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

std::vector<uint8_t> images1d;
std::vector<uint32_t> imageLengths;

CFaceLivenessAuxiliaryInfo getAuxiliaryInfo(const void *object)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    CFaceLivenessAuxiliaryInfo info = CFaceLivenessAuxiliaryInfo();
    const auto state = verifier->GetStage();
    if (state == FaceLivenessVerifierState::Ok) {
        images1d.clear();
        imageLengths.clear();
        for (auto image : verifier->GetAuxiliaryImages()) {
            images1d.insert(images1d.end(), image->begin(), image->end());
            imageLengths.push_back(image->size());
        }
        
        info.images = images1d.data();
        info.imagesSize = images1d.size();
        info.imageLengths = imageLengths.data();
        info.imageLengthsSize = imageLengths.size();
        info.metadata = verifier->GetAuxiliaryImageMetadata().c_str();
        info.metadataSize = verifier->GetAuxiliaryImageMetadata().size();
    }
    return info;
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
