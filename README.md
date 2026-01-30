# ZenID iOS SDK

:bell: SDK version 5.0+ is out now. Please refer to the iOS SDK section of ZenID manual.

Xcode 16 or newer is required.

> [!TIP]
> Code is worth a thousand words. See our sample app in [ZenIDSample](./ZenIDSample).

## Migration from 4.x

See iOS SDK Migration Guide in Feature Notes in ZenID manual.


## iOS version compatibility

We suggest targeting iOS 18.0. Technically this SDK should build for versions 15.0 and above.

Note that old out-of-support devices will likely lack sufficient processing capacity and memory to run the SDK with adequate performance.


## Integration

### Manual linking

- Go to the desired release page (https://github.com/ZenIDTeam/ZenID-ios/releases/latest for latest release), under Assets download "Source code (zip)" and extract the archive.
- Copy `Libraries/ZenID.xcframework`. All required models are now bundled inside the framework.
- If you will use MS Liveness:
  - Also include `Libraries/AzureAIVisionFaceUI.xcframework` (~140MB additional).
  - Then copy the MS Liveness helper files from `MSLivenessHelpers` as described in the manual.
- Add the frameworks to your Xcode target with "Embed & Sign".

Required Info.plist keys:
- NSCameraUsageDescription (camera access)
- If using NFC (when requested): NFCReaderUsageDescription and the appropriate NFC entitlement (com.apple.developer.nfc.readersession.formats)
- If using MS Liveness: network access is required to call Microsoft endpoints

### Swift Package Manager (SPM)

> [!WARNING]
> You'll probably see the following error when trying to install via SPM: `unexpectedly did not find the new dependency in the package graph: sourceControl(identity: zenid-ios, location: `.
> 
> That's because this repo uses Git Large File Storage (LFS) and SPM doesn't work well with Git LFS.
> 
> You'll have to either:
>  - Clone the repo manually and add it as a local SPM package or copy the frameworks manually. Ensure you have Git LFS support installed and enabled when cloning.
>  - Download "Source code (zip)" asset from release page, extract and copy the frameworks from `Libraries/`. This way you don't have to deal with LFS at all.

- Add the package from `https://github.com/ZenIDTeam/ZenID-ios`
- Choose package product:
  - **ZenID** - Lite version (recommended if you don't need MS Liveness)
  - **ZenIDFull** - Full version with MS Liveness support (includes AzureAIVisionFaceUI automatically, adds ~140MB)
- All required models are bundled inside ZenID.xcframework - no manual model management needed.


### How to fix focusing problem with new iPhone Pro models.

You must zoom in on the video stream to compensate for the minimum focus distance and required magnification.
We created a method which do exactly this, so you don't have to write your own. This method is available since
iOS 15 which covers iPhone 13 Pro and newer.

```swift
if #available(iOS 15.0, *) {
    Camera.setRecommendedZoomFactor(for: device) // AVCaptureDevice
}
```

### Open Source licenses

ZenID is powered by Open Source libraries. See [open-source-licenses.txt](./open-source-licenses.txt) for the list and licensing information.
