//
//  CPPWrapper.c
//  RecogLib-iOS
//
//  Created by Marek Stana on 26/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#include "CPPWrapper.h"
#include "include/DocumentPictureVerifier.h"

CDocumentPictureVerifier * CreateCDocumentPictureVerifier(void) {
//    return new DocumentPictureVerifier();
    return new DocumentPictureVerifier("./models");
}

void ReleaseCppClass(CDocumentPictureVerifier * c) {
//    delete c;
}

void CallHelloWorld(CDocumentPictureVerifier * c) {
//    c->Hel
}
