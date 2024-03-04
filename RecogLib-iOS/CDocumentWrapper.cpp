#include "CUtils.hpp"
#include "CDocumentWrapper.hpp"
#include "RecogLibC.h"
#include <CoreMedia/CoreMedia.h>
#include <string>
#include <memory>
#include <optional>
#include <mutex>

using namespace RecogLibC;

std::mutex stateMutex; // TODO: rename to verifierMutex

// TODO: Lock each usage of verifier with:
// std::lock_guard<std::mutex> guard(stateMutex);
// The statement above adds a mutex to the code until the end of the scope

static void processFrame(const void *object, CVPixelBufferRef _cvBuffer, CDocumentInfo *document, const char *acceptableInputJson) {
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
        std::lock_guard<std::mutex> guard(stateMutex);
        verifier->ProcessFrame(image, acceptableInputJson);
    }
    else
    {
        std::lock_guard<std::mutex> guard(stateMutex);
        verifier->ProcessFrame(image,
                               document->role < 0 ? nullptr : &documentRole,
                               document->page < 0 ? nullptr : &country,
                               document->country < 0 ? nullptr : &pageCode,
                               document->code < 0 ? nullptr : &documentCode);
    }
    
    CVPixelBufferUnlockBaseAddress(_cvBuffer, 0);
}

void getDocumentResult(const void *object,  CDocumentInfo *document) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    
    const auto state = verifier->GetState();
    
    if (state == DocumentVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = static_cast<int>(verifier->GetSignature().size());
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = static_cast<int>(verifier->GetSignedImage().size());
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
            
        default:
            document->code = verifier->GetDocumentCode().has_value() ? static_cast<int>(verifier->GetDocumentCode().value()) : -1;
            document->page = verifier->GetPageCode().has_value() ? static_cast<int>(verifier->GetPageCode().value()) : -1;
            document->role = verifier->GetDocumentRole().has_value() ? static_cast<int>(verifier->GetDocumentRole().value()) : -1;
            document->country = verifier->GetCountry().has_value() ? static_cast<int>(verifier->GetCountry().value()) : -1;
            document->state = static_cast<int>(state);
    }
}


void * getDocumentVerifier(CDocumentVerifierSettings *settings)
{
    DocumentVerifierSettings verifierSettings = DocumentVerifierSettings();
    verifierSettings.showTimer = settings->showTimer;
    verifierSettings.drawOutline = settings->drawOutline;
    verifierSettings.visualizerVersion = settings->visualizerVersion;
    DocumentVerifier *verifier = new DocumentVerifier(std::make_shared<DocumentVerifierSettings>(verifierSettings));
    return (void *)verifier;
}

void deleteDocumentVerifier(void *verifier)
{
    delete ((DocumentVerifier *) verifier);
}
                                                      
void loadModel(const void *object, const char* buffer, size_t size)
{
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->LoadModel(buffer, size);
}

void loadTesseractModel(const void *object, const char* resourcePath)
{    
    std::string strPath(resourcePath);
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->LoadTesseractModel(strPath);
}

bool verify(const void *object,
            CMSampleBufferRef _mat,
            CDocumentInfo *document,
            const char *acceptableInputJson)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyImage(object, cvBuffer, document, acceptableInputJson);
}

bool verifyImage(const void *object, CVPixelBufferRef _cvBuffer, CDocumentInfo *document, const char *acceptableInputJson)
{
    processFrame(object, _cvBuffer, document, acceptableInputJson);
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    
    const auto state = verifier->GetState();
    
    if (state == DocumentVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = static_cast<int>(verifier->GetSignature().size());
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = static_cast<int>(verifier->GetSignedImage().size());
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
    verifier->GetSettings().showTimer = settings->showTimer;
    verifier->GetSettings().enableAimingCircle = settings->enableAimingCircle;
    verifier->GetSettings().drawOutline = settings->drawOutline;
    verifier->GetSettings().visualizerVersion = settings->visualizerVersion;
}

bool verifyHologram(const void *object, CMSampleBufferRef _mat, CDocumentInfo *document)
{
    CVImageBufferRef cvBuffer = CMSampleBufferGetImageBuffer(_mat);
    return verifyHologramImage(object, cvBuffer, document);
}

bool verifyHologramImage(const void *object, CVPixelBufferRef _cvBuffer, CDocumentInfo *document)
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
    std::lock_guard<std::mutex> guard(stateMutex);
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->Reset();
}

int validateDocumentsInput(const void *object, const char* acceptableInputJson) {
    std::lock_guard<std::mutex> guard(stateMutex);
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    int size = static_cast<int>(verifier->GetEnabledModels(acceptableInputJson).size());
    return size;
}

char* getDocumentRenderCommands(const void *object, int canvasWidth, int canvasHeight, CDocumentInfo *document)
{
    
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    
    auto language = static_cast<SupportedLanguages>(document->language);
    // No need to add a lock_guard here because GetRenderCommands is the only thread-safe method.
    std::string renderString = verifier->GetRenderCommands(canvasWidth, canvasHeight, language);
    return getString(renderString);
}

void setDocumentDebugInfo(const void *object, bool show)
{
    std::lock_guard<std::mutex> guard(stateMutex);
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    verifier->SetDebugVisualization(show);
}

int getDocumentRequiredFps(const void *object)
{
    DocumentVerifier *verifier =(DocumentVerifier *)object;
    std::optional<int> fps = verifier->GetRequiredVideoFps();
    if (fps) {
        return fps.value();
    }
    return 30;
}

int getDocumentRequiredVideoResolution(const void *object)
{
    DocumentVerifier *verifier =(DocumentVerifier *)object;
    std::optional<int> resolution = verifier->GetRequiredVideoResolution();
    if (resolution) {
        return  resolution.value();
    }
    return 0;
}


char* getNfcKey(const void *object)
{
    DocumentVerifier *verifier =(DocumentVerifier *)object;
    std::string nfcKey = verifier->GetNfcKeyJson();
    return getString(nfcKey);
}

void processNfcResult(const void *object, char *data, enum CNfcStatus status)
{
    DocumentVerifier *verifier =(DocumentVerifier *)object;
//    std::string strData = data;
    NfcStatus mappedStatus;
    switch (status) {
        case CNfcStatus::DeviceDoesNotSupportNfc:
            mappedStatus = NfcStatus::DeviceDoesNotSupportNfc;
            break;
        case CNfcStatus::InvalidNfcKey:
            mappedStatus = NfcStatus::InvalidNfcKey;
            break;
        case CNfcStatus::UserSkipped:
            mappedStatus = NfcStatus::UserSkipped;
            break;
        case CNfcStatus::Ok:
            mappedStatus = NfcStatus::Ok;
            break;
    }
    
    verifier->ProcessNfcResult(data, mappedStatus);
}

NfcStatus mapNfcStatus(CNfcStatus status) {
    switch (status) {
        case CNfcStatus::DeviceDoesNotSupportNfc:
            return  NfcStatus::DeviceDoesNotSupportNfc;
        case CNfcStatus::InvalidNfcKey:
            return  NfcStatus::InvalidNfcKey;
        case CNfcStatus::UserSkipped:
            return  NfcStatus::UserSkipped;
        case CNfcStatus::Ok:
            return  NfcStatus::Ok;
    }
}

int getState(const void *object) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    int state = static_cast<int>(verifier->GetState());
    return state;
}

CImageSignature getSignedImage(const void *object) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    const auto state = verifier->GetState();
    
    if (state == DocumentVerifierState::Ok) {
        CImageSignature signature = CImageSignature();
        signature.signature = verifier->GetSignature().c_str();
        signature.signatureSize = static_cast<int>(verifier->GetSignature().size());
        signature.image = verifier->GetSignedImage().data();
        signature.imageSize = static_cast<int>(verifier->GetSignedImage().size());
        return  signature;
    }
    return CImageSignature();
}

CPreviewData getImagePreview(const void *object, CPreviewData *preview) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    CPreviewData _unusedPreview;
    // I'm trying to solve the deallocation exception by passing the object as an external reference but it didn't solve the problem.
    preview->image = verifier->GetImagePreview().data();
    preview->imageSize = static_cast<int>(verifier->GetImagePreview().size());
    return  _unusedPreview;
}

CNfcValidatorConfig getSdkConfig(const void *object) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    NfcValidatorConfig origConfig = verifier->GetSdkConfig();
    CNfcValidatorConfig config = CNfcValidatorConfig();
    config.isEnabled = origConfig.IsEnabled;
    config.acceptScore = origConfig.AcceptScore;
    config.isTestEnabled = origConfig.IsTestEnabled;
    config.nfcChipReadingTimeoutSeconds = origConfig.NfcChipReadingTimeoutSeconds;
    config.noNfcMeansError = origConfig.NoNfcMeansError;
    config.numberOfReadingAttempts = origConfig.NumberOfReadingAttempts;
    config.scoreStep = origConfig.ScoreStep;
    config.skipNfcAllowed = origConfig.SkipNfcAllowed;
    return  config;
}


CDocumentVerifierSettings getDocumentSettings(const void *object) {
    DocumentVerifier *verifier = (DocumentVerifier *)object;
    DocumentVerifierSettings& verifierSettings = verifier->GetSettings();
    CDocumentVerifierSettings settings = CDocumentVerifierSettings();
    settings.drawOutline = verifierSettings.drawOutline;
    settings.enableAimingCircle = verifierSettings.enableAimingCircle;
    settings.showTimer = verifierSettings.showTimer;
    //settings.platformSupportsNfcFeature = verifierSettings.platformSupportsNfcFeature;
    settings.visualizerVersion = verifierSettings.visualizerVersion;
    return settings;
}
