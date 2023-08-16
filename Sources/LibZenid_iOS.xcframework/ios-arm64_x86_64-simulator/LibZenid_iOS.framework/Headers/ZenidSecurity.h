#pragma once

#include "RecogLibCApi.h"

#ifdef __ANDROID__
#include <jni.h>
#endif

#include <string>

namespace RecogLibC::Security RECOGLIBC_PUBLIC
{

RECOGLIBC_PUBLIC std::string GetChallengeToken();
RECOGLIBC_PUBLIC bool IsAuthorized();
RECOGLIBC_PUBLIC void CheckAuthorization();
RECOGLIBC_PUBLIC bool SelectProfile(const std::string& profileName);


#ifdef __ANDROID__
RECOGLIBC_PUBLIC bool Authorize(JNIEnv* env, jobject _context, jstring responseToken);
#else
RECOGLIBC_PUBLIC bool Authorize(const std::string& responseToken);
#endif
RECOGLIBC_PUBLIC void Unauthorize();
}
