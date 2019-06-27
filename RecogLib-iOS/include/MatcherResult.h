//
//  MatcherResult.h
//  RecogLib-iOS
//
//  Created by Adam Salih on 27/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#ifndef MatcherResult_h
#define MatcherResult_h

#include <stdio.h>


#ifdef __cplusplus
extern "C" {
#endif

struct CMatcherResult {
    int documentRole, documentCountry, documentCode, documentPage, state;
};
typedef struct CMatcherResult CMatcherResult;

CMatcherResult* initMatcherResult(int documentRole, int documentCountry, int documentPage, int documentCode, int state);
void freeMatcherResult(CMatcherResult* result);
int getDocumentRole(CMatcherResult* result);
int getDocumentCountry(CMatcherResult* result);
int getDocumentPage(CMatcherResult* result);
int getDocumentCode(CMatcherResult* result);
int getDocumentState(CMatcherResult* result);

#ifdef __cplusplus
}
#endif

#endif /* MatcherResult_h */
