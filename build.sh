#!/bin/bash
echo $1

sudo rm -r ./Build
sudo rm -r ./Output

mkdir Build
mkdir Output

BUILD=$(realpath ./Build)
OUTPUT=$(realpath ./Output)

#mark this directory as deletable by the build system
xattr -w com.apple.xcode.CreatedByBuildSystem true $BUILD


# iphone simulator

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS" -configuration "Release" -sdk "iphonesimulator" clean build CONFIGURATION_BUILD_DIR=$BUILD

mkdir $OUTPUT/RecogLib_iOS_simulator 
mv $BUILD/RecogLib_iOS.framework "$OUTPUT/RecogLib_iOS_simulator/RecogLib_iOS.framework"
#rm -r "$BUILD/RecogLib_iOS.framework.dSYM"


# iphone

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS" -configuration "Release" -sdk "iphoneos" clean build CONFIGURATION_BUILD_DIR=$BUILD

mkdir $OUTPUT/RecogLib_iOS_device
mv $BUILD/RecogLib_iOS.framework "$OUTPUT/RecogLib_iOS_device/RecogLib_iOS.framework"
#rm -r "$OUTPUT/RecogLib_iOS.framework.dSYM"


# Create xcframework

rm -r "Sources/RecogLib_iOS.xcframework" 
xcodebuild -create-xcframework -framework "$OUTPUT/RecogLib_iOS_simulator/RecogLib_iOS.framework" -framework "$OUTPUT/RecogLib_iOS_device/RecogLib_iOS.framework" -output Sources/RecogLib_iOS.xcframework

sudo rm -r ./Build
sudo rm -r ./Output