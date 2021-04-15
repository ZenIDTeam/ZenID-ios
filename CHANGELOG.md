# Change Log

## 1.27.10 - 2021-04-15
* Updated LibZenid 1.4.3

## 1.27.9 - 2021-04-11
* Updated LibZenid 1.3.3.1

## 1.27.8 - 2021-03-30
* Exportable application log

## 1.27.7 - 2021-03-10
* Updated LibZenid 1.3.3

## 1.27.5 - 2021-02-26
* Fixed portrait mode
* Fit camera mode set as default (and recommended) setting

## 1.27.4 - 2021-02-26
* Mirrored face liveness arrows fixed

## 1.27.3 - 2021-02-25
* Bitcode enabled

## 1.27.2 - 2021-02-24
* Updated LibZenid 1.2.3.1

## 1.27.1 - 2021-02-15
* Updated LibZenid 1.2.3 - The blur, reflection and darkness validators are now more tolerant and reach their maximum tolerance faster. Fix: Show feedback when no card is seen in the SDK hologram validator

## 1.27.0 - 2021-02-14
* Support for document detection in portrait orientation

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
