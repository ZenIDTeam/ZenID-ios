#include "CUtils.hpp"
#include "CSelfieWrapper.hpp"
#include "RecogLibC.h"
#include <CoreMedia/CoreMedia.h>
#include <string>

using namespace RecogLibC;

const void * getSelfieVerifier(CSelfieVerifierSettings *settings)
{
    SelfieVerifierSettings verifierSettings = SelfieVerifierSettings();
    verifierSettings.visualizerVersion = settings->visualizerVersion;
    SelfieVerifier *verifier = new SelfieVerifier(std::make_shared<SelfieVerifierSettings>(verifierSettings));
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
        throw std::runtime_error(std::string("Unsupported format for CVPixelBufferGetPixelFormatType"));
    }
    
    void *data = CVPixelBufferGetBaseAddress(_cvBuffer);
    Image image(data, widht, height, ImageFormat::BGRA, stride);
    //image.Rotate(RotateFlags::Rotate90Clockwise);
    image.FlipHorizontally();
    
    verifier->ProcessFrame(image);
    
    CVPixelBufferUnlockBaseAddress(_cvBuffer, 0 );
    
    const auto state = verifier->GetState();
    
    if (state == SelfieVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = static_cast<int>(verifier->GetSignature().size());
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = static_cast<int>(verifier->GetSignedImage().size());
        selfie->signature = signature;
    }
    
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
