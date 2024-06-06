#include "CUtils.hpp"
#include "CSelfieWrapper.hpp"
#include "RecogLibC.h"
#include <CoreMedia/CoreMedia.h>
#include <string>

using namespace RecogLibC;

static std::mutex verifierProcessFrameMutex; // Used to prevent verifier methods from running running concurrently, for eg. Reset and ProcessFrame
static std::shared_mutex verifierDeleteMutex; // Used to prevent the verifier from being deleted while a background thread is running


void * getSelfieVerifier(CSelfieVerifierSettings *settings)
{
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    SelfieVerifierSettings verifierSettings = SelfieVerifierSettings();
    verifierSettings.visualizerVersion = settings->visualizerVersion;
    SelfieVerifier *verifier = new SelfieVerifier(std::make_shared<SelfieVerifierSettings>(verifierSettings));
    return (void *)verifier;
}

void deleteSelfieVerifier(void *verifier)
{
    std::unique_lock<std::shared_mutex> unique_lock(verifierDeleteMutex);
    delete ((SelfieVerifier *) verifier);
}

void loadSelfie(const void *object,
                const char *modelPath)
{
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    std::lock_guard<std::mutex> guard(verifierProcessFrameMutex);
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    if (!verifier) throw std::runtime_error("SelfieVerifier is null.");
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
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    std::lock_guard<std::mutex> guard(verifierProcessFrameMutex);
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    if (!verifier) throw std::runtime_error("SelfieVerifier is null.");
    
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
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    std::lock_guard<std::mutex> guard(verifierProcessFrameMutex);
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    if (!verifier) throw std::runtime_error("SelfieVerifier is null.");
    verifier->Reset();
}

char* getSelfieRenderCommands(const void *object,
                            int canvasWidth,
                            int canvasHeight,
                            CSelfieInfo *selfie)
{
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    
    auto language = static_cast<SupportedLanguages>(selfie->language);
    
    std::string renderString = verifier->GetRenderCommands(canvasWidth, canvasHeight, language);
    return getString(renderString);
}

void setSelfieDebugInfo(const void *object,
                       bool show)
{
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    std::lock_guard<std::mutex> guard(verifierProcessFrameMutex);
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    if (!verifier) throw std::runtime_error("SelfieVerifier is null.");
    verifier->SetDebugVisualization(show);
}

CSelfieVerifierSettings getSelfieSettings(const void *object) {
    std::shared_lock<std::shared_mutex> shared_lock(verifierDeleteMutex);
    std::lock_guard<std::mutex> guard(verifierProcessFrameMutex);
    SelfieVerifier *verifier = (SelfieVerifier *)object;
    if (!verifier) throw std::runtime_error("SelfieVerifier is null.");
    SelfieVerifierSettings& verifierSettings = verifier->GetSettings();
    
    CSelfieVerifierSettings settings = CSelfieVerifierSettings();
    settings.visualizerVersion = verifierSettings.visualizerVersion;
    return settings;
}
