//
//  CDocumentWrapper.hpp
//  RecogLib-iOS
//
//  Created by Marek Stana on 26/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#ifndef CDocumentWrapper_hpp
#define CDocumentWrapper_hpp

#include <stdio.h>
#include <string.h>
#include <CoreMedia/CoreMedia.h>

#ifdef __cplusplus
extern "C" {
#endif
struct CDocumentInfo {
    int role, country, code, page, state;
};
typedef struct CDocumentInfo CDocumentInfo;

const void * loadWrapper(const char * path);
bool verify(const void *object, CMSampleBufferRef _mat, CDocumentInfo *document, float _horizontalMargin, float _verticalMargin);
bool verifyImage(const void *object, CVPixelBufferRef _cvBuffer, CDocumentInfo *document, float _horizontalMargin, float _verticalMargin);

    
#ifdef __cplusplus
}
#endif

#endif /* CDocumentWrapper_hpp */
