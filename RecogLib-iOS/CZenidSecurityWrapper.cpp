//
//  CZenidSecurityWrapper.cpp
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 10/07/2020.
//  Copyright © 2020 Marek Stana. All rights reserved.
//

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

