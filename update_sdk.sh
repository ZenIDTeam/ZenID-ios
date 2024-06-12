#!/usr/bin/env bash

if [ -z "$1" ] 
    then
        echo "Script for updating ZenID SDK"
        echo "Hint: <ZENID_GIT_ROOT>/update_sdk_sh <PATH_TO_DOWNLOADED_FILES> <VERSION>" 
        echo "May the force be with you!"
else
    if [ -f "./scripts/c_enums_to_swift.sh" ]; then

        set -e

        ./scripts/verify_extract_sdk.sh $1 $2

        echo "Generating enums to the file 'RecogLib-iOS/SDK/Enums.generated.swift' ..."

        ./scripts/c_enums_to_swift.sh ./Sources/LibZenid_iOS.xcframework/ios-arm64/LibZenid_iOS.framework/Headers/ZenidEnums.generated.h > ./RecogLib-iOS/SDK/Enums.generated.swift

        # ./build.sh

        echo "Continue SDK update in Xcode"

    else
        echo "ERROR: Shall be called from ZenID Demo repository root."
    fi
fi
