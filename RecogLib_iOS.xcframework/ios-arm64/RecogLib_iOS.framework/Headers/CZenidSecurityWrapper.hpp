//
//  CZenidSecurityWrapper.hpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 10/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

#ifndef CZenidSecurityWrapper_hpp
#define CZenidSecurityWrapper_hpp

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

char* getChallengeToken();
bool authorize(const char* responseToken);
bool isAuthorized();

#ifdef __cplusplus
}
#endif

#endif /* CZenidSecurityWrapper_hpp */
