#!/bin/bash
echo $1

rm -r LibZenid_iOS.xcframework
xcodebuild -create-xcframework -framework "$1/Release-iphonesimulator/LibZenid_iOS.framework" -framework "$1/Release-iphoneos/LibZenid_iOS.framework" -output LibZenid_iOS.xcframework

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS Release" -configuration "Release" -sdk "iphonesimulator" CONFIGURATION_BUILD_DIR=. clean build

mkdir RecogLib_iOS_simulator 
mv RecogLib_iOS.framework "RecogLib_iOS_simulator/RecogLib_iOS.framework"
rm -r RecogLib_iOS.framework
rm "RecogLib_iOS.framework.dSYM"

xcodebuild -project RecogLib-iOS.xcodeproj -scheme "RecogLib-iOS Release" -configuration "Release" -sdk "iphoneos" CONFIGURATION_BUILD_DIR=. clean build

mkdir RecogLib_iOS_device
mv RecogLib_iOS.framework "RecogLib_iOS_device/RecogLib_iOS.framework"
rm -r "RecogLib_iOS.framework.dSYM"

rm -r "RecogLib_iOS.xcframework" 
xcodebuild -create-xcframework -framework "RecogLib_iOS_simulator/RecogLib_iOS.framework" -framework "RecogLib_iOS_device/RecogLib_iOS.framework" -output RecogLib_iOS.xcframework

rm -r "RecogLib_iOS_simulator"
rm -r "RecogLib_iOS_device"