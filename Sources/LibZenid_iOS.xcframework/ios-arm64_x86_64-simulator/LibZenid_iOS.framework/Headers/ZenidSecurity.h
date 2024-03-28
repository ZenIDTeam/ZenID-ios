#pragma once

#include "RecogLibCApi.h"

#ifdef __ANDROID__
#include <jni.h>
#endif

#include <string>

namespace RecogLibC RECOGLIBC_NONE
{
namespace Security RECOGLIBC_PUBLIC
{

RECOGLIBC_PUBLIC std::string GetChallengeToken(); // this creates a new challenge token to be used for initSdk calls. If you call this again without calling authorize, same token will be returned.
RECOGLIBC_PUBLIC bool IsAuthorized();
RECOGLIBC_PUBLIC void CheckAuthorization();
RECOGLIBC_PUBLIC bool SelectProfile(const std::string& profileName);
RECOGLIBC_PUBLIC std::string GetEnabledFeaturesJson();


#ifdef __ANDROID__
RECOGLIBC_PUBLIC bool Authorize(JNIEnv* env, jobject _context, jstring responseToken);
#else
RECOGLIBC_PUBLIC bool Authorize(const std::string& responseToken);
#endif
RECOGLIBC_PUBLIC void Unauthorize();
}
}
