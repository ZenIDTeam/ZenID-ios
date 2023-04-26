#pragma once

#ifdef __ANDROID__
#include <jni.h>
#endif

#include <string>

namespace RecogLibC::Security
{

std::string GetChallengeToken();
bool IsAuthorized();
void CheckAuthorization();


#ifdef __ANDROID__
bool Authorize(JNIEnv* env, jobject _context, jstring responseToken);
#else
bool Authorize(const std::string& responseToken);
#endif
void Unauthorize();
}
