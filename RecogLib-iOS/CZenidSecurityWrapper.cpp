#include "CUtils.hpp"
#include "CZenidSecurityWrapper.hpp"
#include "RecogLibC.h"
#include <stdio.h>

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
    std::string authorizedMessage = std::string("RecogLibC.authorized result = ") + (authorized ? "true" : "false");
    RecogLibC::ZenidLog::GetDefault().Debug(authorizedMessage + "\n");
    
    bool profileSelected = RecogLibC::Security::SelectProfile("");
    std::string profileSelectedMessage = std::string("RecogLibC.profileSelected result = ") + (profileSelected ? "true" : "false");
    RecogLibC::ZenidLog::GetDefault().Debug(profileSelectedMessage + "\n");
    return authorized && profileSelected;
}

void log(char *message)
{
    
}

bool isAuthorized()
{
    bool isAuthorized = RecogLibC::Security::IsAuthorized();
    return isAuthorized;
}

bool selectProfile(const char* profileName)
{
    std::string name(profileName);
    bool result = RecogLibC::Security::SelectProfile(name);
    return result;
}


