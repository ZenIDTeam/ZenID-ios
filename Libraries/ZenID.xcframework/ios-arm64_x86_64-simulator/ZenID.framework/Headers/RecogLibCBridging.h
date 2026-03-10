//
//  RecogLibCBridging.h
//  LibZenid-iOS
//
//  Created by Vladimir Belohradsky on 26.06.2025.
//

#ifndef RecogLibCBridging_h
#define RecogLibCBridging_h

#include <stdio.h>

#include <CoreMedia/CoreMedia.h>

#ifdef __cplusplus
extern "C" {
#endif

// Error handling — thread-local last error set by bridge functions on C++ exception.
// Swift calls GetLastError after each bridge call to detect failures.
const char * _Nullable RecogLibC_GetLastError(void);
void RecogLibC_ClearLastError(void);

// Version.h
const char * _Nonnull Version_RecogLibCGetVersion(void);

// ZenidSecurity.h
const char * _Nullable ZenidSecurity_GetChallengeToken(); // this creates a new challenge token to be used for initSdk
bool ZenidSecurity_IsAuthorized();
bool ZenidSecurity_SelectProfile(const char * _Nonnull profile);
bool ZenidSecurity_Authorize(const char * _Nonnull token, const char * _Nonnull bundleIdentifier);
void ZenidSecurity_Unauthorize();
const char * _Nullable ZenidSecurity_GetEnabledVerifiersJson();
const char * _Nullable ZenidSecurity_GetEnabledDocumentsJson();
const char * _Nullable ZenidSecurity_GetSdkWizardStepsJson();

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

void VerifierManager_InitOrRestart(const char * _Nonnull feature, const char * _Nonnull jsSettings);
void VerifierManager_RestartWithPreviousSettings(const char * _Nonnull feature);
bool VerifierManager_ReadyForFrame(const char * _Nonnull feature);
void VerifierManager_ProcessFrameFromSampleBuffer(const char * _Nonnull feature, CMSampleBufferRef _Nonnull _mat);
void VerifierManager_ProcessFrameFromPixelBuffer(const char * _Nonnull feature, CVPixelBufferRef _Nonnull _cvBuffer);
void VerifierManager_SubmitExternalResponse(const char * _Nonnull feature, const char * _Nonnull responseJson);
const char * _Nullable VerifierManager_GetUploadReadyData(const char * _Nonnull feature);
const char * _Nullable VerifierManager_GetRenderCommands(const char * _Nonnull feature, int width, int height);
const char * _Nullable VerifierManager_GetStateContainerJson(const char * _Nonnull feature);
void VerifierManager_Unload(const char * _Nonnull feature);
void VerifierManager_SetLanguage(const char * _Nonnull language);
void VerifierManager_SetVisualizerVersion(int visualizerVersion);
void VerifierManager_SetDebugVisualization(bool enabled);
bool VerifierManager_GetDebugVisualization();
const char * _Nullable VerifierManager_GetLanguage();
const char * _Nullable VerifierManager_GetLanguageLocale();
bool VerifierManager_IsFeatureLoaded(const char * _Nonnull feature);
int VerifierManager_GetFrameProcessingResolution(const char * _Nonnull feature);
int VerifierManager_GetSupportedPageCount(const char *documentCode);


#ifdef __cplusplus
}
#endif

#endif /* RecogLibCBridging_h */
