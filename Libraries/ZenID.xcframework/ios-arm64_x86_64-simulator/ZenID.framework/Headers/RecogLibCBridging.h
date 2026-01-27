//
//  RecogLibCBridging.h
//  LibZenid-iOS
//
//  Created by Vladimir Belohradsky on 26.06.2025.
//

#ifndef RecogLibCBridging_h
#define RecogLibCBridging_h

#include <stdio.h>

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wunused-variable"
//#pragma clang diagnostic ignored "-Wunused-function"
//#pragma clang diagnostic ignored "-Wdocumentation"
//#pragma clang diagnostic ignored "-Wquoted-include-in-framework-header"

//#define FMT_HEADER_ONLY

//#include <RecogLibC_Unity.generated.cpp>

//#pragma clang diagnostic pop

#include <CoreMedia/CoreMedia.h>

#ifdef __cplusplus
extern "C" {
#endif

// Version.h
const char *Version_RecogLibCGetVersion(void);

// ZenidSecurity.h
const char *ZenidSecurity_GetChallengeToken(); // this creates a new challenge token to be used for initSdk
bool ZenidSecurity_IsAuthorized();
bool ZenidSecurity_SelectProfile(const char *profile);
bool ZenidSecurity_Authorize(const char *token, const char *bundleIdentifier);
void ZenidSecurity_Unauthorize();
const char *ZenidSecurity_GetEnabledVerifiersJson();
const char *ZenidSecurity_GetEnabledDocumentsJson();
const char *ZenidSecurity_GetSdkWizardStepsJson();

// ModelLoader

typedef struct ModelFile {
    const uint8_t* data;
    int64_t size;
} ModelFile;

void setModelLoaderCallback();
ModelFile load_model(const char* resourcePath, const char* fileName);

// Logger

void Logger_ClearZenidListeners();
void Logger_AddZenidListener();
void logger_write(int32_t level, const char* message);

// Verifier Manager

void VerifierManager_InitOrRestart(const char *feature, const char *jsSettings);
void VerifierManager_RestartWithPreviousSettings(const char *feature);
bool VerifierManager_ReadyForFrame(const char *feature);
void VerifierManager_ProcessFrameFromSampleBuffer(const char *feature, CMSampleBufferRef _mat);
void VerifierManager_ProcessFrameFromPixelBuffer(const char *feature, CVPixelBufferRef _cvBuffer);
void VerifierManager_SubmitExternalResponse(const char *feature, const char *responseJson);
const char *VerifierManager_GetUploadReadyData(const char *feature);
const char *VerifierManager_GetRenderCommands(const char *feature, int width, int height);
const char *VerifierManager_GetStateContainerJson(const char *feature);
void VerifierManager_Unload(const char *feature);
void VerifierManager_SetLanguage(const char *language);
void VerifierManager_SetVisualizerVersion(int visualizerVersion);
void VerifierManager_SetDebugVisualization(bool enabled);
bool VerifierManager_GetDebugVisualization();
const char *VerifierManager_GetLanguage();
const char *VerifierManager_GetLanguageLocale();
bool VerifierManager_IsFeatureLoaded(const char *feature);
int VerifierManager_GetFrameProcessingResolution(const char *feature);


#ifdef __cplusplus
}
#endif

#endif /* RecogLibCBridging_h */
