# OpenCV
This guide explains the procedure where to obtain OpenCV and how to compile it for [RecogLib](README.md)

## Setup

### 1. The source code
Download the source code and unzip it
```
https://github.com/opencv/opencv/releases/tag/4.1.0
https://github.com/opencv/opencv_contrib/releases/tag/4.1.0
```
or just use these commands
```
mkdir opencv && cd opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.0.zip
unzip opencv_contrib.zip
unzip opencv.zip
rm opencv_contrib.zip
rm opencv.zip 
```

### 2. Copy dependent modules
Copy `face` and `xfeatures2d` folders from `./opencv_contrib/modules` to `./opencv/modules`
```
cp -R opencv_contrib-4.1.0/modules/face/ opencv-4.1.0/modules/face/
cp -R opencv_contrib-4.1.0/modules/xfeatures2d/ opencv-4.1.0/modules/xfeatures2d/
rm -rf opencv_contrib
```

### 4. Compile it!
Go to ios platform folder located at  `./opencv-4.1.0/platforms/ios/`
```
cd opencv-4.1.0/platforms/ios/
```
and compile it using following command
```
python2.7 ./build_framework.py ios --iphoneos_archs arm64,arm64e --iphonesimulator_archs x86_64 --enable_nonfree --dynamic --iphoneos_deployment_target 11.0
```

GOOD TO KNOW
- if you want rebuild framework multiple times remove ios folder that contains framework product located at `./opencv-4.1.0/platforms/ios/`

### 5. Profit
That's it. You will find the compiled framework at `./opencv-4.1.0/platforms/ios/ios/` with name `opencv2.framework`



