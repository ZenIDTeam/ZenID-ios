//
//  CPPWrapper.h
//  RecogLib-iOS
//
//  Created by Marek Stana on 26/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#ifndef CPPWrapper_h
#define CPPWrapper_h

#include <stdio.h>

typedef struct DocumentPictureVerifier CDocumentPictureVerifier;

#ifdef __cplusplus
extern "C" {
#endif
    CDocumentPictureVerifier * CreateCDocumentPictureVerifier(void);
    void ReleaseCppClass(CDocumentPictureVerifier * c);
    void CallHelloWorld(CDocumentPictureVerifier * c);

#ifdef __cplusplus
}
#endif

#endif /* CPPWrapper_h */
