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
struct CMatcherResult {
    int documentRole, documentCountry, documentCode, documentPage, state;
};
typedef struct CMatcherResult CMatcherResult;

const void * loadWrapper(const char * path);
CMatcherResult verify(const void *object, CMSampleBufferRef _mat, CMatcherResult *result, float _horizontalMargin, float _verticalMargin, int _documentRole, int _country, int _pageCode);

#ifdef __cplusplus
}
#endif

#endif /* CDocumentWrapper_hpp */
