//
//  main.cpp
//  RecogLib-iOS
//
//  Created by Marek Stana on 24/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

#include "FaceLivenessDetector.h"
#include "DocumentPictureVerifier.h"

#include "samples/MatcherSample.h"
#include "samples/FaceLivenessSample.h"

//#include <iostream>

int main(int argc, char** argv)
{
    using namespace RecogLibC;
    if (argc > 1)
    {
        if (std::string(argv[1]) == "--face" || std::string(argv[1]) == "-f")
        {
            DetectFaceLiveness();
            return 0;
        }
        if (std::string(argv[1]) == "--document" || std::string(argv[1]) == "-d")
        {
            VerifyDocumentFromVideo();
            return 0;
        }
    }

    std::cout << "Usage: Program [OPTIONS]" << std::endl;
    std::cout << "Options are" << std::endl;
    std::cout << "           -f, --face  Detect face liveness" << std::endl;
    std::cout << "           -d, --document  Verify document picture from video" << std::endl;

    return 0;
}
