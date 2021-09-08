# Change Log

## 1.4 - 2021-09-03
* Added support for Faceliveness `dark` and `blurry` state.
* Updated LibZenid to 1.8.5.

## 1.3.1 - 2021-08-23
* Updated LibZenid to 1.8.4.

## 1.3.0 - 2021-07-29
* Added support for Image signature.
* Updated LibZenid to 1.7.3.

## 1.27.20 - 2021-07-15
* Removed embedded LibZenid framework from RecogLib.
* Fixed LibZenid versioning issue.
* Updated LibZenid to 1.6.31.
* Added Bitcode Support.

## 1.27.19 - 2021-07-13
* Fixed Country and Role of DocumentVerifier Result object.

## 1.27.18 - 2021-07-12
* Added the ability to change documents input once the `DocumentVerifier` is initialized.

## 1.27.17 - 2021-07-01
* Added support for scanning multiple predefined documents.
* Added Document Verifier Settings to be able to tune the sensitivity of the verifier. 
* Added Support for EHIC, GUN, and RES documents.
* Updated LibZenid 1.6.3.1.

## 1.27.12 - 2021-04-28
* acceptable input json support for document verifier 

## 1.27.11 - 2021-04-26
* Updated for Xcode 12.5

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
