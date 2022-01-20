//
//  CDocumentWrapper.cpp
//  RecogLib-iOS
//
//  Created by Marek Stana on 26/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#include "CUtils.hpp"
#include "CDocumentWrapper.hpp"
#include "RecogLibC.h"
#include <CoreMedia/CoreMedia.h>
#include <string>
#include <memory>

using namespace RecogLibC;

static void processFrame(const void *object,
                  CVPixelBufferRef _cvBuffer,
                  CDocumentInfo *document,
                  const char *acceptableInputJson)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    
    // Construct optional data
    auto documentRole = static_cast<DocumentRole>(document->role);
    auto country = static_cast<Country>(document->country);
    auto pageCode = static_cast<PageCodes>(document->page);
    auto documentCode = static_cast<DocumentCodes>(document->code);
    auto orientation = static_cast<int>(document->orientation);
    
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
    
    switch (orientation) {
        case 1: // portrait
            break;
            
        case 2: // portraitUpsideDown
            image.Rotate(RotateFlags::Rotate180);
            break;
            
        case 3: // landscapeRight
            image.Rotate(RotateFlags::Rotate90CounterClockwise);
            break;
            
        case 4: // landscapeLeft
            image.Rotate(RotateFlags::Rotate90Clockwise);
            break;
            
        default:
            break;
    }

    if (acceptableInputJson != NULL)
    {
        verifier->ProcessFrame(image, acceptableInputJson);
    }
    else
    {
        verifier->ProcessFrame(image,
                               document->role < 0 ? nullptr : &documentRole,
                               document->page < 0 ? nullptr : &country,
                               document->country < 0 ? nullptr : &pageCode,
                               document->code < 0 ? nullptr : &documentCode);
    }
    
    CVPixelBufferUnlockBaseAddress(_cvBuffer, 0);
}


const void * getDocumentVerifier(CDocumentVerifierSettings *setttings)
{
    DocumentVerifierSettings verifierSettings = DocumentVerifierSettings();
    verifierSettings.specularAcceptableScore = setttings->specularAcceptableScore;
    verifierSettings.documentBlurAcceptableScore = setttings->documentBlurAcceptableScore;
    verifierSettings.timeToBlurMaxToleranceInSeconds = setttings->timeToBlurMaxToleranceInSeconds;
    verifierSettings.showTimer = setttings->showTimer;
    DocumentVerifier *verifier = new DocumentVerifier(std::make_shared<DocumentVerifierSettings>(verifierSettings));
    return (void *)verifier;
}
                                                      
void loadModel(const void *object,
               const char* buffer,
               size_t size)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->LoadModel(buffer, size);
}

bool verify(const void *object,
            CMSampleBufferRef _mat,
            CDocumentInfo *document,
            const char *acceptableInputJson)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyImage(object, cvBuffer, document, acceptableInputJson);
}

bool verifyImage(const void *object,
                 CVPixelBufferRef _cvBuffer,
                 CDocumentInfo *document,
                 const char *acceptableInputJson)
{
    processFrame(object, _cvBuffer, document, acceptableInputJson);
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    
    const auto state = verifier->GetState();
    
    if (state == DocumentVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = verifier->GetSignature().size();
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = verifier->GetSignedImage().size();
        document->signature = signature;
    }
    
    document->state = static_cast<int>(state);
    if (state == DocumentVerifierState::Hologram) {
        document->hologramState = static_cast<int>(verifier->GetHologramState());
        if (verifier->GetHologramState() == HologramState::Ok) {
            document->state = static_cast<int>(DocumentVerifierState::Ok);
        }
    }
    
    switch (state) {
        case RecogLibC::DocumentVerifierState::NoMatchFound:
            document->code = -1;
            document->page = -1;
            document->role = -1;
            document->country = -1;
            return false;
            
        default:
            document->code = verifier->GetDocumentCode().has_value() ? static_cast<int>(verifier->GetDocumentCode().value()) : -1;
            document->page = verifier->GetPageCode().has_value() ? static_cast<int>(verifier->GetPageCode().value()) : -1;
            document->role = verifier->GetDocumentRole().has_value() ? static_cast<int>(verifier->GetDocumentRole().value()) : -1;
            document->country = verifier->GetCountry().has_value() ? static_cast<int>(verifier->GetCountry().value()) : -1;
            document->state = static_cast<int>(state);
            return true;
    }
}

void updateDocumentVerifierSettings(const void *object, CDocumentVerifierSettings *settings) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->GetSettings().specularAcceptableScore = settings->specularAcceptableScore;
    verifier->GetSettings().documentBlurAcceptableScore = settings->documentBlurAcceptableScore;
    verifier->GetSettings().timeToBlurMaxToleranceInSeconds = settings->timeToBlurMaxToleranceInSeconds;
    verifier->GetSettings().showTimer = settings->showTimer;
}

bool verifyHologram(const void *object,
                 CMSampleBufferRef _mat,
                 CDocumentInfo *document)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyHologramImage(object, cvBuffer, document);
}

bool verifyHologramImage(const void *object,
                 CVPixelBufferRef _cvBuffer,
                 CDocumentInfo *document)
{
    processFrame(object, _cvBuffer, document, NULL);
    
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    document->hologramState = static_cast<int>(verifier->GetHologramState());
    switch (verifier->GetState()) {
        case RecogLibC::DocumentVerifierState::NoMatchFound:
            return false;
        default:
            return true;
    }
}

void beginHologramVerification(const void *object)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->BeginHologramVerification();
}

void endHologramVerification(const void *object)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->EndHologramVerification();
}

void reset(const void *object)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->Reset();
}

int validateDocumentsInput(const void *object, const char* acceptableInputJson) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    int size = verifier->GetEnabledModels(acceptableInputJson).size();
    return size;
}

char* getDocumentRenderCommands(const void *object,
                        int canvasWidth,
                        int canvasHeight,
                        CDocumentInfo *document)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    
    auto language = static_cast<SupportedLanguages>(document->language);
    
    std::string renderString = verifier->GetRenderCommands(canvasWidth, canvasHeight, language);
    return getString(renderString);
}

void setDocumentDebugInfo(const void *object,
                      bool show)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->SetDebugVisualization(show);
}

