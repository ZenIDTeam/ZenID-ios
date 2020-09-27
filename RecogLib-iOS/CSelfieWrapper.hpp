//
//  CSelfieWrapper.hpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 23/09/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

#ifndef CSelfieWrapper_hpp
#define CSelfieWrapper_hpp

#include <stdio.h>
#include <string.h>
#include <CoreMedia/CoreMedia.h>

#ifdef __cplusplus
extern "C" {
#endif

struct CSelfieInfo {
    int state, orientation, language;
};

typedef struct CSelfieInfo CSelfieInfo;

// Initialisation and loading models
const void * getSelfieVerifier();
void loadSelfie(const void *object, const char* modelPath);

// Verifying faces
bool verifySelfie(const void *object, CMSampleBufferRef _mat, CSelfieInfo *selfie);
bool verifySelfieImage(const void *object, CVPixelBufferRef _cvBuffer, CSelfieInfo *selfie);

// Visualisation
char* getSelfieRenderCommands(const void *object, int canvasWidth, int canvasHeight, CSelfieInfo *selfie);
void setSelfieDebugInfo(const void *object, bool show);

#ifdef __cplusplus
}
#endif

#endif /* CSelfieWrapper_hpp */
