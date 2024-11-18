# Change Log

# 4.4.14 2024-11-08
Fix: Implicitly set the camera represented by the Camera object to autofocus. TRASKZENIDPV-3206
Fix: Fixes torch on iOS 17. TRASKZENIDPV-3056 (Backported from 4.5.8)
Fix: Fix for crash when CVPixelBuffer is empty. SZENID-2831 (Backported from 4.5.7)
Fix: For Czech birth certificate, any Match found on frontend is used. TRASKZENIDPV-3127 (Backported from 4.5.5)
Improvement: ApplicationLogger is no longer available. Use ZenidSecurity.setLogger(_ logger: LoggerProtocol) instead. TRASKZENIDPV-3023 (Backported from 4.5.3)
Fix: Fixes hologram torch malfunctioning on iOS 18 TRASKZENIDPV-3056 (Backported from 4.5.5)
New: Support for German Driving license v2013/2021. TRASKZENIDPV-3052 TRASKZENIDPV-3054 (Backported from 4.5.2)
New: Support for German Driving license v1999/2001/2004/2011. TRASKZENIDPV-3055 TRASKZENIDPV-3053 (Backported from 4.5.2)
New: Support for Maltese Driving license v2013/2020. TRASKZENIDPV-3047 TRASKZENIDPV-3049 (Backported from 4.5.3)
SDK: Default values for time to max tolerance for Blur and Darkness validators were increased to 60. TRASKZENIDPV-2969 
Fix: Remove dependency on Roboto font. TRASKZENIDPV-2728
Improvement: Add posibility to move scanning area. TRASKZENIDPV-2895
Fix: Added another possible validity limit for German Passport v2017. SZENID-2719
Improvement: The investigation results show the grey problem messages with scores of Blur and Specular validators from the SDK whenever they are lower than 100. TRASKZENIDPV-2900 
Fix: Preventing of the MRZ reading exception if backend nor frontend can't read it. SZENID-2652 (Backported to 4.3.12)
Fix: Updated last name parsing on Czech Birth certificate to address names with wide kerning. SZENID-2644

# 2.0.28 2024-07-12
* RecogLib 4.3.10
* SDK: There was a minor issue where the Darkness and Specular validators were passed incorrect values. TRASKZENIDPV-2786
* Fix: FrontendValidatorType field in Signature renamed back to ValidatorType. TRASKZENIDPV-2774
* Fix: Updated model for Czech Residency permit v2020/2022 for better alignment and OCR. TRASKZENIDPV-2576 TRASKZENIDPV-2620
* Improvement: When hough tracker matches a model but the surf doesn't verify it, we reset the hough match. TRASKZENIDPV-2689
* SDK: If one document is replaced by another during the scanning process using the SDK, all validators are reset, and only the data related to the last scanned document is sent to the backend. SZENID-2666
* Improvement: Further decrease risk of document misclassification. TRASKZENIDPV-2689
* Fixed mutex error when calling SelectProfile. SZENID-2656
* Improvement: Added support for the YUV_420_888 format. TRASKZENIDPV-2449
* Improvement: Decreased risk of misclassifying documents. TRASKZENIDPV-2269, TRASKZENIDPV-2689
* Fix: Updated Olympus card MRZ reading for nationality, sometimes failing before. TRASKZENIDPV-2648
* Fix: Conditions affecting MRZ reading in CoreLib are consistent. TRASKZENIDPV-2648

# 2.0.27 2024-07-08
* RecogLib 4.2.17
* Improvement: Decreased risk of misclassifying documents. SZENID-2633, SZENID-2634 (Backported from 4.3.4)
* Improvement: Decreased risk of misclassifying documents. TRASKZENIDPV-2269, TRASKZENIDPV-2689 (Backported from 4.3.5)
* Improvement: Validators' results are set for the best frame (not for the last frame). TRASKZENIDPV-2556 (Backported from 4.3.9)
* Improvement: `NfcStatus` enum uses proper Swift camel case naming.

# 2.0.27 2024-06-26
* RecogLib 4.2.15
* Fix: If one document is replaced by another during the scanning process using the SDK, all validators are reset, and only the data related to the last scanned document is sent to the backend. SZENID-2666 (Backported from 4.3.7)
* Fix: GetStepParameters returns `totalCheckCount`, `passedCheckCount` and `hasFailed` even for background checks. SZENID-2625 (Backported from 4.3.8)
* New: FaceLivenessController new method `getStepParameters` to return current steps parameters.

# 2.0.27 2024-06-13
* RecogLib 4.2.13
* Fix: Fixed mutex error when calling SelectProfile.
* New: Can automatically load models from Bundles inside app when using CocoaPods distribution.
* Fix: Hologram and Faceliveness process is automatically restarted when user leave and return to the app.
* Fix: SelfieController can't produce other data type than `.picture`. Delegate method with video output was removed.

# 2.0.27 2024-06-04
* RecogLib 4.2.10
* Fix: `GetStepParameters` always sets `totalCheckCount`, `passedCheckCount` and `hasFailed` values of json.

# 2.0.27 2024-05-03
* RecogLib 4.2.7
* Fix: Addresses on RO ID cards that contain parentheses are parsed correctly.
* Fix: Lost face in face liveness causes the process to be restarted when "Face must be stable and detectable all the time" is set to true. (Backported to 4.1.9)
* Fix: Fixed Selfie validator for cards with NFC, it uses image from NFC everytime. (Backported to 3.10.8 and 4.1.9)
* Fix: Better OCR for Czech residency permit permit numbers.
* Improvement: Retrained Card face validator detector.
* Improvement: Added Field retrain submission support. Problematic fields can be sent for OCR retrain if this feature is enabled in settings.

# 2.0.27 2024-04-29
* RecogLib 4.2.5
* Fix: Fix C being read as € in addresses on Slovak ID card.
* Fix: Css style settings correctly passed to visualization.
* Fix: Fixed the DocumentVerifier getting stuck in TextNotReadable state while trying to scan the MRZ.

# 2.0.26 2024-04-29
* RecogLib 4.1.9
* Fix: Fixed Selfie validator for cards with NFC, it uses image from NFC everytime.
* Fix: The score of the problem generated by the Consistency between Documents Validator corresponds to the value calculated by the validator itself.
* Fix: Lost face in face liveness causes the process to be restarted when "Face must be stable and detectable all the time" is set to true.


# 2.0.26 2024-03-04
* RecogLib 4.1.7
* Various performance and stability improvements.
* New: Localization to be overrided by client application.
* Fix: Camera object now respond to UI orientation and not Device orientation.
* Fix: Remove unwanted initial visualisation v1 animation.
* Fix: For visualisation v1 flickering on slower devices.
* Fix: `Camera` object Torch stays on after device orientation changed.
* New: Add optional controllers parameter `showTextInstructions` to disable text instructions in build-in visualisation.
* New: All controllers has new init parameter to select Language for visualisation v1 tips. If parameter left empty it detects language from Locale and use one of available languages [English, Czech, German, Polish]. If locale isn't matching any of the languages it fall back to English.
* Improved reliability.

# 2.0.25 2024-02-01
* RecogLib 3.10.4
* Improvement: Camera and CameraView are now public and can be mutated in VerifierControllers.
* Improvement: CameraView is no longer in strong relationship and it is app responsibility to keep reference.
* New: SDK has three new functions in ZenidSecurity that list and check countries and documents enabled by licence.
* Fix: SDK has better memory management.
* Improvement: NFC dialog support Czech locale.

# 2.0.24 2023-12-18
* RecogLib 3.10.1
* Added new possible values to HologramState enum: TiltLeft, TiltRight, TiltUp, TiltDown. Those represent the states of the new IQS hologram UI.
* Improve compatibility with future iOS SDKs.
* Improve camera focusing (without image juping) on new iPhone Pro models.

# 2.0.23 2023-12-08
* RecogLib 3.9.6
* New: Support for Vaticanian passports v2013 (NFC only).
* New: Support for Liechtensteiner passports v2006 (NFC only).
* Improvement: Improved wording of Normalization parameters on Settings page.
* Improvement: Retrained Mask on selfie validator.
* New: Support for Andorran passports v2017 (NFC only).
* New: Support for Sanmarinese passports v2006 (NFC only).
* New: System updated to enable support for documents with just extracting its NFC data.
* Improvement: Description of ZenidWebSdk.snapNow() method in manual. This function skips validators and signature is not created.
* New: Support for Belgian Passport v2022.
* Improvement: Signature is copied to clipboard with prefix.
* Hide current step UI during TimedOut state.
* Improvement: *Italian ID cards suppord broadened: Italian ID cards v2016/2022.
* Add HologramState::TimedOut to expose timeout condition in IQS hologram flow.
* New: `CameraView` class can be initialized from XIB or Storyboard.
* New: You can override default videogravity using parameter in `CameraView`.
* New: Parameter `ignoreSafeArea` in `CameraView` will stretch video view to fill whole UIView and ignore safe areas.
* New: Video recording reset together with Liveness verifier to reduce video length.

# 2.0.22 2023-10-13
* RecogLib 3.8.5
* New: Added support for iPhone 15 line
* Turkish passports v2023 are enabled for NFC reading.
* New: Support for Dominican ID cards v2014.
* Improvement: Dominican ID card MRZ reading.
* Don't show card outline after card is removed from frame in IQS verifier.
* New: Possibility to change time delay to become max tolerant for multiple FE validators has been added to SDK picture quality validator on the Sensitivity page.
* New: Added WebView visualizer files to SDK releases.
* SDK: Allow setting IQS verifier settings in backend validator sensitivity.

# 2.0.21 2023-09-30
* RecogLib 3.8.1
* New support for NFC document reading (see MIGRATION.md)
* New `DocumentControllerDelegate` method `func controller(_ controller: DocumentController, didScan result: DocumentResult, nfcCode: String)`
* New `NfcDocumentReader` class
* New SelectProfile feature that allows customers to set frontend validator configs on the backend.
* New states for DocumentVerifierState and FaceLivenessVerifierState.
* Removed attributes `specularAcceptableScore`, `documentBlurAcceptableScore` and `readBarcode` from struct `DocumentVerifierSettings`
* New `FaceLivenessVerifier` result state `DontSmile`.

# 2.0.20 2023-06-15
* Hologram length video reducing
* Fixed issue when completing the face-liveness verification proces

# 2.0.19 2023-06-10
* Fixed a memory issue in demo app

# 2.0.18 2023-05-12
* RecogLib 3.5.1
* Added CZ_RES_2020_A2 in DocumentCodes enum.
* Added OL_IDC_2022 in DocumentCodes enum, Exp (Experimental card) to DocumentRole and Ol (Olympus, experimental) to Country.
* Support for experimental 'Olympus' ID card v2022.
* Fixed a crash that could happen when resetting face liveness workflow with debug visualization enabled.
* Fixed issue with starting and stopping camera cature session in demo app

# 2.0.17 2023-03-07
* RecogLib 3.3.1
* The face liveness check takes a selfie picture at a random point while performing the steps.
* The face liveness check retakes a new selfie picture after a failed attempt.

# 2.0.16 2023-03-01
* RecogLib 3.2.4
* Fix tracking issues when the card is far from the center.
* SDK: When the image is blurry, an animation is shown to the user to indicate that he should move the phone further away from the card.
* SDK: The SDK won't take a picture of the card when it's too far outside the outline.
* New: Support for Swedish ID cards v2022.
* New: Support for Indian passports v2000/2013.
* New: Support for Swedish passports v2022.
* New: Support for Danish passports v2021.
* New: Support for Swiss passports v2022.
* New: Support for Vietnamese passports v2022.
* Improvement: Support for new variant of Montenegrin passport.
* API: Added SE_IDC_2022, SE_PAS_2022, DK_PAS_2021, CH_PAS_2022, ME_PAS_2008_A2 and VN_PAS_2022 in DocumentCodes enum.
* Added usurf_in_pas_2000_13_f.bin
* Added usurf_se_idc_2022_f.bin
* Added usurf_se_idc_2022_b.bin
* Added usurf_se_pas_2022_f.bin
* Added usurf_dk_pas_2021_f.bin
* Added usurf_ch_pas_2022_f.bin
* Added usurf_vn_pas_2022_f.bin


# 2.0.15 2023-01-07
* RecogLib 2.12.3
* Fix bug that could cause issues in tracking especially with Birth Certificates.
* New: Support for Slovak ID cards v2022 TRASKZENIDPV-749

# 2.0.14 2022-11-28
* RecogLib 2.11.3
* Fix issue with Birth Certificate tracking. TRASKZENIDPV-588
* FPS and resolution width of selfie video and document video can be changed in Settings and the values are exposed to SDK. TRASKZENIDPV-468
* Important: The default value of parameter *drawOutline* in DocumentVerifierSettings changed from *false* to *true*

## 2.0.13 2022-11-07
* RecogLib 2.11.1
* New: Support for Slovak residency permits v2011. TRASKZENIDPV-388
* New: Support for Lithuanian ID cards (v2021). TRASKZENIDPV-461
* Fixed hologram check getting stuck in the "align card" step.

## 2.0.12 2022-10-25
* RecogLib 2.10.4
* Improved tracking and classification of documents.
* Added the modelhashes.bin model, used for all countries for documents and holograms.
* Added RO_IDC_2021sep in DocumentCodes enum.
* Added RecogLibCAssertionException that is thrown for failed internal assertions. It's derived from RecogLibCException, so no code changes are necessary on the implementer side.
* Added additional parameters describing the liveness check steps. ZenID-issues#2736
* Fix the darkness validator being too strict.
* Fix a bug that reduces tracking accuracy. ZenID-issues#2741
* Fix a bug when Romanian ID cannot be detected


## 2.0.11 2022-10-03
* Support for Serbian passports (v2008). ZenID-issues#2617
* Support for Bosnian passports (v2014). ZenID-issues#2618
* Support for Albanian passports (v2009). ZenID-issues#2619
* Support for Macedonian passports (v2007). ZenID-issues#2620
* Support for Belarussian passports (v2006 and v2021). ZenID-issues#2621
* Support for Montenegrin passports (v2008). ZenID-issues#2617
* Support for Norwegian passports (v2011/2015 and v2020). ZenID-issues#2634
* Support for Polish passport version 2011. ZenID-issues#2585 SZENID-1694
* Support for Croatian passport version 2009/2015. ZenID-issues#2585 SZENID-1694
* Support for Moldovan passports (v2011/2014/2018). ZenID-issues#2637
* Support for Icelandic passports (v2019 and v2006). ZenID-issues#2638

## 2.0.10 2022-09-09
* Fix for NL DRV 2013
* Fix Selfie cannot snap  after reject button tap

## 2.0.9 2022-08-25
* Updated LibZenid 2.8.3
* New: Support for Dutch driving license (v2013 and v2014). ZenID-issues#2514
* New: Support for Swiss passport (v2010). ZenID-issues#2514
* Added Al, By, Ba, Me, Mk, Rs, Ch to Country.
* Added AL_PAS_2009, BA_PAS_2014, CH_PAS_2010, ME_PAS_2008, MK_PAS_2007, RS_PAS_2008, NO_PAS_2020, NO_PAS_2011_15 in DocumentCodes enum.
* Support for British passports (v2010/2011/2015/2019).
* Fix of the issue "The smile animation is not shown"
* New model for German ID also able to read 2021

## 2.0.8 2022-07-25
* Updated LibZenid 2.7.4
* Fix Support for Czech birth certificate - version 2001. ZenID-issues#2500
* Added usurf_hr_idc_2003_f.bin

## 2.0.7 2022-07-18
* Updated LibZenid 2.7.3
* Fixed failed assertion in face liveness and selfie liveness introduced in 2.6.4. (websdk as well as sdks)
* New: Support for Czech birth certificate - version 2001. ZenID-issues#2500
* Added usurf_hr_idc_2003_f.bin
* Add support for mac catalyst

## 2.0.6 2022-07-01
* Updated LibZenid 2.6.3
* Support for ARM simulator builds in iOS
* Fix Faceliveness visualizer

## 2.0.5 2022-05-25
* Updated LibZenid 2.5.1
* The recoglibc*.bin models were renamed to usurf*.bin and the file names were switched to lowercase.
* Switched to a combined xcframework instead of two frameworks

## 2.0 - 2022-04-28
* Refactored SDK. Checkout the Readme file.

## 1.18 - 2022-04-22
* Added CaseIterable support for DocumentCode enum.

## 1.17 - 2022-04-17
* Added Swift 5.6 and Xcode 13.3 support

## 1.16 - 2022-04-14
* Updated LibZenid to 2.4.2.
* Added ReadBarcode option into DocumentSettings.
* Added the ability to turn off the logging of scanning.
* New models:
  recoglibc_UA_DRV_2005_F.bin,
  recoglibc_UA_DRV_2016_F.bin
* New DocumentCodes:
  UA_DRV_2016,
  UA_DRV_2005


## 1.15 - 2022-04-06
* Updated LibZenid to 2.4.11.
* Added DrawOutline option into DocumentSettings.
* Fixed missing built-in feedback text in the FaceLivenessVerifier.
* New models:
  recoglibc_AT_IDC_2021_B.bin,
  recoglibc_AT_IDC_2021_F.bin,
  recoglibc_BG_IDC_2010_B.bin,
  recoglibc_BG_IDC_2010_F.bin,
  recoglibc_BG_PAS_2010_F.bin,
  recoglibc_EU_VIS_2019_F.bin,
  recoglibc_UA_IDC_2017_B.bin,
  recoglibc_UA_IDC_2017_F.bin,
  recoglibc_UA_PAS_2007_15_F.bin
* New DocumentCodes:
  UA_PAS_2007_15,
  UA_IDC_2017,
  EU_VIS_2019
* New DocumentRole:
  Vis

## 1.14 - 2022-03-22
* Updated LibZenid to 2.3.11.
* DocumentVerifierState Barcode new state.
* New models:
  recoglibc_CZ_RES_2006_07_B.bin,
  recoglibc_CZ_RES_2006_07_F.bin,
  recoglibc_CZ_RES_2006_T_B.bin,
  recoglibc_CZ_RES_2006_T_F.bin,
  recoglibc_PL_DRV_1999_F.bin

## 1.12 - 2022-02-21
* Updated LibZenid to 2.1.41.
* Added AimingCircle option into DocumentSettings.

## 1.11 - 2022-01-21
* Updated LibZenid to 2.1.4.
* Activated DocumentVerifier Hologram methods.

## 1.10 - 2021-12-31
* Added Support for HR ID 2021.
* Added Faceliveness metadata.

## 1.9 - 2021-12-17
* Updated LibZenid to 1.12.11.
* Changed face models.
* Added HR 2021 ID models.

## 1.8 - 2021-09-29
* Updated LibZenid to 1.10.3.
* Added Croatia models of ID cards.

## 1.7 - 2021-09-28
* Changed format of LibZenid and RecogLib frameworks to XCFrameworks. Please, read the Readme 1.7.0 migration tutorial.

## 1.6 - 2021-09-21
* Updated RecogLib to support Swift 5.5

## 1.5 - 2021-09-15
* Updated LibZenid to 1.9.1. (Fixed blur validation for Slovak ID cards)

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
