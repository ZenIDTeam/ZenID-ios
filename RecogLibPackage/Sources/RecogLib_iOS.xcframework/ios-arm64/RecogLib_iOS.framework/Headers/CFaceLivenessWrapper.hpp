#ifndef FaceLivenessWrapper_hpp
#define FaceLivenessWrapper_hpp

#include <stdio.h>
#include <string.h>
#include <CoreMedia/CoreMedia.h>
#include "CImageSignature.hpp"

#ifdef __cplusplus
extern "C" {
#endif

struct CFaceLivenessInfo {
    int state, orientation, language;
    struct CImageSignature signature;
};

struct CFaceLivenessAuxiliaryInfo {
    const uint8_t *images;
    int imagesSize;
    const uint32_t *imageLengths;
    int imageLengthsSize;
    const char *metadata;
    int metadataSize;
};

typedef struct CFaceLivenessInfo CFaceLivenessInfo;
typedef struct CFaceLivenessAuxiliaryInfo CFaceLivenessAuxiliaryInfo;

struct CFaceLivenessVerifierSettings {
    bool enableLegacyMode;
    int maxAuxiliaryImageSize;
};

typedef struct CFaceLivenessVerifierSettings CFaceLivenessVerifierSettings;

// Initialisation and loading models
const void * getFaceLivenessVerifier(const char* resourcesPath, CFaceLivenessVerifierSettings *settings);

// Verifying faces
bool verifyFaceLiveness(const void *object, CMSampleBufferRef _mat, CFaceLivenessInfo *faceDetector);
bool verifyFaceLivenessImage(const void *object, CVPixelBufferRef _cvBuffer, CFaceLivenessInfo *faceDetector);
void updateFacelivenessVerifierSettings(const void *object, CFaceLivenessVerifierSettings *settings);

// Auxiliary Images Info
CFaceLivenessAuxiliaryInfo getAuxiliaryInfo(const void *object);

// Reset
void faceLivenessVerifierReset(const void *object);

// Visualisation
char* getFaceLivenessRenderCommands(const void *object, int canvasWidth, int canvasHeight, CFaceLivenessInfo *faceDetector);
void setFaceLivenessDebugInfo(const void *object, bool show);

#ifdef __cplusplus
}
#endif

#endif /* FaceLivenessWrapper_hpp */
