#!/usr/bin/env bash

set -e

sudo chown -R $(whoami):staff $1
sudo chmod -R 0775 $1

./scripts/verify_extract_sdk.sh $1 $2

echo "Generating enums to the file 'RecogLib-iOS/SDK/Enums.generated.swift' ..."

./scripts/c_enums_to_swift.sh Sources/LibZenid_iOS.xcframework/ios-arm64/LibZenid_iOS.framework/Headers/ZenidEnums.generated.h > RecogLib-iOS/SDK/Enums.generated.swift

#./build.sh

echo "SDK update completed 🎉🎉"