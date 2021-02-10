# Change Log

## 1.26.2 - 2021-02-10
* Support for camera display modes
* Updated for Xcode 12.4.

## 1.26.0 - 2020-12-15
* Ability to scan an unspecified document in SDK
* Updated for Xcode 12.3. / Swift 5.3.2

## 1.25.2 - 2020-12-12
* Updated LibZenid 0.25.2 -  includes an improved blur detector. No change needed for consumers of the library


## 1.25.1 - 2020-11-30
* Preview photo orientation is the same as the camera orientation


## 1.25 - 2020-11-29

* Rename `FaceLivenessVerifierStage` to `FaceLivenessVerifierState`
* Rename `FaceLivenessVerifierState::Done` to `FaceLivenessVerifierState::Ok`
* `FaceLivenessVerifier.GetRenderCommands` takes a width and height instead of `cv::Size`
* Add the `Crop` method to `Image`.
* The `SelfieVerifier` returns `SelfieVerifierState::ConfirmingFace` when the face circle is green.
* The `SelfieVerifier` returns `SelfieVerifierState::Dark` when the picture is too dark.
