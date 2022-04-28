#include "CUtils.hpp"
#include "CZenidSecurityWrapper.hpp"
#include "RecogLibC.h"

using namespace RecogLibC;

char* getChallengeToken()
{
    std::string token = RecogLibC::Security::GetChallengeToken();
    return getString(token);
}

bool authorize(const char* responseToken)
{
    std::string str(responseToken);
    bool authorized = RecogLibC::Security::Authorize(str);
    return authorized;
}

bool isAuthorized()
{
    bool isAuthorized = RecogLibC::Security::IsAuthorized();
    return isAuthorized;
}

