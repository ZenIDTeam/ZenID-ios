#ifndef CSelfieWrapper_hpp
#define CSelfieWrapper_hpp

#include <stdio.h>
#include <string.h>
#include <CoreMedia/CoreMedia.h>
#include "CImageSignature.hpp"

#ifdef __cplusplus
extern "C" {
#endif

struct CSelfieInfo {
    int state, orientation, language;
    struct CImageSignature signature;
};

typedef struct CSelfieInfo CSelfieInfo;
struct CSelfieVerifierSettings {
    int visualizerVersion;
};

typedef struct CSelfieVerifierSettings CSelfieVerifierSettings;
// Initialisation and loading models
const void * getSelfieVerifier(CSelfieVerifierSettings *settings);
void loadSelfie(const void *object, const char* modelPath);

// Verifying faces
bool verifySelfie(const void *object, CMSampleBufferRef _mat, CSelfieInfo *selfie);
bool verifySelfieImage(const void *object, CVPixelBufferRef _cvBuffer, CSelfieInfo *selfie);

// Reset
void selfieVerifierReset(const void *object);

// Visualisation
char* getSelfieRenderCommands(const void *object, int canvasWidth, int canvasHeight, CSelfieInfo *selfie);
void setSelfieDebugInfo(const void *object, bool show);

#ifdef __cplusplus
}
#endif

#endif /* CSelfieWrapper_hpp */
