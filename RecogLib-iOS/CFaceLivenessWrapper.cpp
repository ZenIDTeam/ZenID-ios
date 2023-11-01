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
    verifierSettings.visualizerVersion = settings->visualizerVersion;
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
    //image.Rotate(RotateFlags::Rotate90Clockwise);
    image.FlipHorizontally();
    
    verifier->ProcessFrame(image);
    
    CVPixelBufferUnlockBaseAddress(_cvBuffer, 0 );
    
    const auto state = verifier->GetStage();
    
    if (state == FaceLivenessVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = static_cast<int>(verifier->GetSignature().size());
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = static_cast<int>(verifier->GetSignedImage().size());
        face->signature = signature;
    }
    
    if (state != RecogLibC::FaceLivenessVerifierState::Ok) {
        face->state = static_cast<int>(state);
        return false;
    }

    face->state = static_cast<int>(state);
    return true;
}

void updateFacelivenessVerifierSettings(const void *object, CFaceLivenessVerifierSettings *settings) {
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    verifier->GetSettings().enableLegacyMode = settings->enableLegacyMode;
    verifier->GetSettings().maxAuxiliaryImageSize = settings->maxAuxiliaryImageSize;
    verifier->GetSettings().visualizerVersion = settings->visualizerVersion;
    verifier->Reset();
}

CFaceLivenessAuxiliaryInfo getAuxiliaryInfo(const void *object)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;
    CFaceLivenessAuxiliaryInfo info = CFaceLivenessAuxiliaryInfo();
    const auto state = verifier->GetStage();
    if (state == FaceLivenessVerifierState::Ok) {
        std::vector<uint8_t> images1d;
        std::vector<uint32_t> imageLengths;
        for (auto image : verifier->GetAuxiliaryImages()) {
            images1d.insert(images1d.end(), image->begin(), image->end());
            imageLengths.push_back(static_cast<int>(image->size()));
        }
        
        uint8_t* cImages1d = new uint8_t[images1d.size()];
        for (int i = 0; i < images1d.size(); i++) {
            cImages1d[i] = images1d[i];
        }
        uint32_t* cImageLengths = new uint32_t[imageLengths.size()];
        for (int i = 0; i < imageLengths.size(); i++) {
            cImageLengths[i] = imageLengths[i];
        }
        
        char *metadata = NULL;
        metadata = strdup(verifier->GetAuxiliaryImageMetadata().c_str());
        
        info.images = cImages1d;
        info.imagesSize = static_cast<int>(images1d.size());
        info.imageLengths = cImageLengths;
        info.imageLengthsSize = static_cast<int>(imageLengths.size());
        info.metadata = metadata;
        info.metadataSize = static_cast<int>(strlen(metadata));
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

char* getFaceLivenessStepParameters(const void *object)
{
    FaceLivenessVerifier *verifier = (FaceLivenessVerifier *)object;

    std::string stepParametersJson = verifier->GetStepParametersJson();
    return getString(stepParametersJson);
}

int getFaceLivenessRequiredFps(const void *object)
{
    FaceLivenessVerifier *verifier =(FaceLivenessVerifier *)object;
    std::optional<int> fps = verifier->GetRequiredVideoFps();
    if (fps) {
        return fps.value();
    }
    return 30;
}

int getFaceLivenessRequiredVideoResolution(const void *object)
{
    FaceLivenessVerifier *verifier =(FaceLivenessVerifier *)object;
    std::optional<int> resolution = verifier->GetRequiredVideoResolution();
    if (resolution) {
        return  resolution.value();
    }
    return 0;
}

void getFaceLivenessResult(const void *object, CFaceLivenessInfo *face) {
    FaceLivenessVerifier *verifier =(FaceLivenessVerifier *)object;
    
    const auto state = verifier->GetStage();
    
    if (state == FaceLivenessVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = static_cast<int>(verifier->GetSignature().size());
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = static_cast<int>(verifier->GetSignedImage().size());
        face->signature = signature;
    }
    face->state = static_cast<int>(state);
}
