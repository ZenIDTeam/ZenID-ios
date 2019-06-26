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

    const void * initializeListWrapper(void *object);
    bool load(const void *object);
    bool verify(const void *object);

#ifdef __cplusplus
}
#endif



#endif /* CDocumentWrapper_hpp */
