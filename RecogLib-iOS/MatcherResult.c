//
//  MatcherResult.c
//  RecogLib-iOS
//
//  Created by Adam Salih on 27/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#include "include/MatcherResult.h"
#include <stdlib.h>

CMatcherResult* initMatcherResult(int documentRole, int documentCountry, int documentPage, int documentCode, int state) {
    CMatcherResult* result = (CMatcherResult*) malloc(sizeof(CMatcherResult));
    result->documentRole = documentRole;
    result->documentCountry = documentCode;
    result->documentPage = documentPage;
    result->documentCode = documentCode;
    result->state = state;
    return result;
}

void freeMatcherResult(CMatcherResult* result) {
    free(result);
}

int getDocumentRole(CMatcherResult* result){
    return result->documentRole;
}

int getDocumentCountry(CMatcherResult* result){
    return result->documentCountry;
}

int getDocumentPage(CMatcherResult* result){
    return result->documentPage;
}

int getDocumentCode(CMatcherResult* result){
    return result->documentCode;
}

int getDocumentState(CMatcherResult* result){
    return result->state;
}

