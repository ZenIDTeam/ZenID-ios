//
//  FaceDetectorWrapper.hpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 19/05/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

#ifndef FaceWrapper_hpp
#define FaceWrapper_hpp

#include <stdio.h>
#include <string.h>
#include <CoreMedia/CoreMedia.h>

#ifdef __cplusplus
extern "C" {
#endif

struct CFaceInfo {
    int stage, orientation, language;
};

typedef struct CFaceInfo CFaceInfo;

// Initialisation and loading models
const void * getFaceVerifier(const char* resourcesPath, const char* lbfModelContents, size_t lbfModelSize);

// Verifying faces
bool verifyFace(const void *object, CMSampleBufferRef _mat, CFaceInfo *faceDetector);
bool verifyFaceImage(const void *object, CVPixelBufferRef _cvBuffer, CFaceInfo *faceDetector);
void faceVerifierReset(const void *object);

// Visualisation
char* getFaceRenderCommands(const void *object, int canvasWidth, int canvasHeight, CFaceInfo *faceDetector);
void setFaceDebugInfo(const void *object, bool show);

#ifdef __cplusplus
}
#endif

#endif /* FaceDetectorWrapper_hpp */
