//
//  FaceLivenessWrapper.hpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 19/05/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

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

typedef struct CFaceLivenessInfo CFaceLivenessInfo;

// Initialisation and loading models
const void * getFaceLivenessVerifier(const char* resourcesPath, const char* lbfModelContents, size_t lbfModelSize);

// Verifying faces
bool verifyFaceLiveness(const void *object, CMSampleBufferRef _mat, CFaceLivenessInfo *faceDetector);
bool verifyFaceLivenessImage(const void *object, CVPixelBufferRef _cvBuffer, CFaceLivenessInfo *faceDetector);

// Reset
void faceLivenessVerifierReset(const void *object);

// Visualisation
char* getFaceLivenessRenderCommands(const void *object, int canvasWidth, int canvasHeight, CFaceLivenessInfo *faceDetector);
void setFaceLivenessDebugInfo(const void *object, bool show);

#ifdef __cplusplus
}
#endif

#endif /* FaceLivenessWrapper_hpp */
