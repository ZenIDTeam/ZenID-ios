#ifndef CZenidLogWrapper_hpp
#define CZenidLogWrapper_hpp

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

void clearZenidListeners();
void addZenidListener();
void logger_error(const char* message);

#ifdef __cplusplus
}
#endif

#endif /* CZenidLogWrapper_hpp */
