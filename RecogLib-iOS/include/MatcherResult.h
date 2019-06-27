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

struct MatcherResult {
    int documentRole, documentCountry, documentCode, documentPage, state;
};

struct MatcherResult* initMatcherResult();
void freeMatcherResult(struct MatcherResult* result);

#endif /* MatcherResult_h */
