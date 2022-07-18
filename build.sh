#!/bin/bash
echo $1

# rm -r LibZenid_iOS.xcframework
# xcodebuild -create-xcframework -framework "$1/Release-iphonesimulator/LibZenid_iOS.framework" -framework "$1/Release-iphoneos/LibZenid_iOS.framework" -output LibZenid_iOS.xcframework


# iphone simulator

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS" -configuration "Release" -sdk "iphonesimulator" CONFIGURATION_BUILD_DIR=. clean build

mkdir RecogLib_iOS_simulator 
mv RecogLib_iOS.framework "RecogLib_iOS_simulator/RecogLib_iOS.framework"
rm -r RecogLib_iOS.framework
rm "RecogLib_iOS.framework.dSYM"

# iphone

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS" -configuration "Release" -sdk "iphoneos" CONFIGURATION_BUILD_DIR=. clean build

mkdir RecogLib_iOS_device
mv RecogLib_iOS.framework "RecogLib_iOS_device/RecogLib_iOS.framework"
rm -r "RecogLib_iOS.framework.dSYM"

# Mac catalyst

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS" -configuration "Release" -sdk "macosx" CONFIGURATION_BUILD_DIR=. clean build

mkdir RecogLib_macOS
mv RecogLib_iOS.framework "RecogLib_macOS/RecogLib_iOS.framework"
rm -r "RecogLib_iOS.framework.dSYM"


# Create xcframework

rm -r "Sources/RecogLib_iOS.xcframework" 
xcodebuild -create-xcframework -framework "RecogLib_iOS_simulator/RecogLib_iOS.framework" -framework "RecogLib_iOS_device/RecogLib_iOS.framework" -framework "RecogLib_macOS/RecogLib_iOS.framework" -output Sources/RecogLib_iOS.xcframework

rm -r "RecogLib_iOS_simulator"
rm -r "RecogLib_iOS_device"
rm -r "RecogLib_macOS"
rm -r "LibZenid_iOS.framework"
