#ifndef CZenidSecurityWrapper_hpp
#define CZenidSecurityWrapper_hpp

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

char* getChallengeToken();
bool authorize(const char* responseToken);
bool isAuthorized();
bool selectProfile(const char* profileName);

#ifdef __cplusplus
}
#endif

#endif /* CZenidSecurityWrapper_hpp */
