# Change Log

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
