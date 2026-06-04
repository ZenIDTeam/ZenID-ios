# ZenID iOS SDK

:bell: SDK version 5.0+ is out now. Please refer to the iOS SDK section of ZenID manual.

Xcode 16 or newer is required.

> [!TIP]
> Code is worth a thousand words. See our sample app in [ZenIDSample](./ZenIDSample).

## Migration from 4.x

See iOS SDK Migration Guide in Feature Notes in ZenID manual.

## Upgrading from an earlier 5.x release

The SDK frameworks are no longer committed to this repository — they are distributed as GitHub release archives:

- **SwiftPM users:** no action needed. Re-resolve packages; SwiftPM fetches the frameworks from the release automatically. Git LFS is no longer required.
- **Manual integrators:** switch to Swift Package Manager if you can — it works now (no Git LFS required) and is the recommended way to integrate the SDK. If you really need manual integration, run `./download_frameworks.sh` after cloning to populate `Libraries/` (see *Manual linking* below).
- **MS Liveness:** the integration helpers now ship as the `ZenIDMSLiveness` module in the `ZenIDFull` product. After updating, adopt it in two steps: **(1)** add `import ZenIDMSLiveness` to the files that use the helpers, and **(2)** delete the `MSLivenessSwiftUIHelper.swift` / `MSLivenessUIKitHelper.swift` files you previously copied into your app. The `import` only makes the module available — it does not remove your old copies, so step 2 is on you. The module's API is identical, so your existing `.msLiveness(coordinator:)` / `MSLivenessUIKitHelper` call sites need no changes. If you skip step 2, the build stops with an `ambiguous use of 'msLiveness(coordinator:)'` error naming both copies — so it can't slip through silently; just delete the copied file.


## iOS version compatibility

We suggest targeting iOS 18.0. Technically this SDK should build for versions 15.0 and above.

Note that old out-of-support devices will likely lack sufficient processing capacity and memory to run the SDK with adequate performance.


## Integration

### Manual linking

- Clone the repo: `git clone https://github.com/ZenIDTeam/ZenID-ios.git`
- Run `./download_frameworks.sh` to fetch the SDK frameworks into `Libraries/`. They are distributed as GitHub release archives and verified against the checksums in `Package.swift`.
- Add `Libraries/ZenID.xcframework` to your app's Xcode target with "Embed & Sign". All required models are bundled inside the framework — no separate model files needed.
- If you will use MS Liveness:
  - Also add `Libraries/AzureAIVisionFaceUI.xcframework` (~140MB additional) with "Embed & Sign".
  - Copy the MS Liveness helper files from `MSLivenessHelpers` into your project, as described in the manual.

Required Info.plist keys:
- NSCameraUsageDescription (camera access)
- If using NFC (when requested): NFCReaderUsageDescription and the appropriate NFC entitlement (com.apple.developer.nfc.readersession.formats)
- If using MS Liveness: Network access is required. The SDK communicates directly with Microsoft Azure endpoints (not through api.zenid.cz). Ensure your firewall allows access to the Azure endpoint configured in your ZenID license. The Azure endpoint is created on demand for each customer.

### Swift Package Manager (SPM)

- Add the package from `https://github.com/ZenIDTeam/ZenID-ios`
- Choose package product:
  - **ZenID** - Lite version (recommended if you don't need MS Liveness)
  - **ZenIDFull** - Full version with MS Liveness support (includes AzureAIVisionFaceUI automatically, adds ~140MB)
- All required models are bundled inside ZenID.xcframework - no manual model management needed.

The SDK frameworks are delivered as GitHub release archives, referenced from `Package.swift` by `binaryTarget` url + checksum. SwiftPM downloads and verifies them automatically — Git LFS is not required.

If you select **ZenIDFull** and use MS Liveness, `import ZenIDMSLiveness` for the integration helpers (`.msLiveness(coordinator:)` for SwiftUI, `MSLivenessUIKitHelper` for UIKit) — there are no helper files to copy.


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
