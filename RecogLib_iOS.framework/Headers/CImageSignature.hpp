//
//  CImageSignature.hpp
//  RecogLib-iOS
//
//  Created by Libor Polehna on 28.07.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

#ifndef CImageSignature_hpp
#define CImageSignature_hpp

#include <stdio.h>
#include <CoreMedia/CoreMedia.h>

struct CImageSignature {
    const uint8_t *image;
    int imageSize;
    const char *signature;
    int signatureSize;
};

#endif /* CImageSignature_hpp */
