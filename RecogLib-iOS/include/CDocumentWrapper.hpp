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

#ifdef __cplusplus
extern "C" {
#endif

    const void * loadWrapper(const char * path);
    bool verify(const void *object, long _mat, int _documentRole, int _pageCode, int _country);

#ifdef __cplusplus
}
#endif



#endif /* CDocumentWrapper_hpp */
