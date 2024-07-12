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
    int visualizerVersion;
    bool showTimer, enableAimingCircle, drawOutline;
};

enum CNfcStatus {
  DeviceDoesNotSupportNfc = 0,
  InvalidNfcKey = 1,
  UserSkipped = 2,
  Ok = 3,
};

struct CNfcValidatorConfig {
    int numberOfReadingAttempts;
    bool skipNfcAllowed;
    bool noNfcMeansError;
    bool isEnabled;
    int acceptScore;
    int scoreStep;
    bool isTestEnabled;
};

struct CPreviewData {
    const uint8_t *image;
    int imageSize;
};

typedef struct CImageSignature CImageSignature;
typedef struct CDocumentInfo CDocumentInfo;
typedef struct CDocumentVerifierSettings CDocumentVerifierSettings;
typedef struct CNfcValidatorConfig CNfcValidatorConfig;
typedef struct CPreviewData CPreviewData;
    

// Initialisation and loading models
void * getDocumentVerifier(CDocumentVerifierSettings *settings);
void deleteDocumentVerifier(void *verifier);
void loadModel(const void *object, const char* buffer, size_t size);
void loadTesseractModel(const void *object, const char* resourcePath);

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

// Nfc
char* getNfcKey(const void *object);
void processNfcResult(const void *object, char *data, enum CNfcStatus status);
CImageSignature getSignedImage(const void *object);
CNfcValidatorConfig getSdkConfig(const void *object);

// Get state
int getState(const void *object);
void getDocumentResult(const void *object,  CDocumentInfo *document);
//CPreviewData getImagePreview(const void *object, CPreviewData *preview);
CDocumentVerifierSettings getDocumentSettings(const void *object);

#ifdef __cplusplus
}
#endif

#endif /* CDocumentWrapper_hpp */
