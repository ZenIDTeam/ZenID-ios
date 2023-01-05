#ifndef CDocumentWrapper_hpp
#define CDocumentWrapper_hpp

#include <stdio.h>
#include <string.h>
#include <CoreMedia/CoreMedia.h>
#include "CImageSignature.hpp"

#ifdef __cplusplus
extern "C" {
#endif

struct CDocumentInfo {
    int language, role, country, code, page, state, hologramState, orientation;
    struct CImageSignature signature;
};

struct CDocumentVerifierSettings {
    int specularAcceptableScore, documentBlurAcceptableScore, timeToBlurMaxToleranceInSeconds, visualizerVersion;
    bool showTimer, enableAimingCircle, drawOutline, readBarcode;
};

typedef struct CImageSignature CImageSignature;
typedef struct CDocumentInfo CDocumentInfo;
typedef struct CDocumentVerifierSettings CDocumentVerifierSettings;

// Initialisation and loading models
const void * getDocumentVerifier(CDocumentVerifierSettings *settings);
void loadModel(const void *object, const char* buffer, size_t size);

// Verifying documents
bool verify(const void *object, CMSampleBufferRef _mat, CDocumentInfo *document, const char *acceptableInputJson);
bool verifyImage(const void *object, CVPixelBufferRef _cvBuffer, CDocumentInfo *document, const char *acceptableInputJson);
void updateDocumentVerifierSettings(const void *object, CDocumentVerifierSettings *settings);

// Verifying holograms
bool verifyHologram(const void *object, CMSampleBufferRef _mat, CDocumentInfo *document);
bool verifyHologramImage(const void *object, CVPixelBufferRef _cvBuffer, CDocumentInfo *document);
void beginHologramVerification(const void *object);
void endHologramVerification(const void *object);

// Reset
void reset(const void *object);

// Input Validation
int validateDocumentsInput(const void *object, const char* acceptableInputJson);

// Visualisation
char* getDocumentRenderCommands(const void *object, int canvasWidth, int canvasHeight, CDocumentInfo *document);
void setDocumentDebugInfo(const void *object, bool show);

// Get video settings
int getDocumentRequiredFps(const void *object);
int getDocumentRequiredVideoResolution(const void *object);


#ifdef __cplusplus
}
#endif

#endif /* CDocumentWrapper_hpp */
