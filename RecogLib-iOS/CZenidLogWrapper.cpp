#include "CUtils.hpp"
#include "CZenidLogWrapper.hpp"
#include "RecogLibC.h"
#include <iostream>

using namespace RecogLibC;

void clearZenidListeners() {
    RecogLibC::ZenidLog::GetDefault().ClearListeners();
}

void addZenidListener() {
    RecogLibC::ZenidLog::GetDefault().AddListener(LogLevel::Debug, [](LogLevel level, const std::string& message) {
        //std::cout << message;
        //std::cout.flush();
        
        //logger_error(message.c_str());
    });
}
