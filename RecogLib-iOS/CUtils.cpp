#include "CUtils.hpp"

char* getString(std::string token)
{
    const char *cString = token.c_str();
    char *result = (char*) malloc(strlen(cString) + 1);
    strcpy(result, cString);
    
    // Caller must release the pointer!
    return result;
}
