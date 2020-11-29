# Change Log

## 1.25 - 2020-11-29

* Rename `FaceLivenessVerifierStage` to `FaceLivenessVerifierState`
* Rename `FaceLivenessVerifierState::Done` to `FaceLivenessVerifierState::Ok`
* `FaceLivenessVerifier.GetRenderCommands` takes a width and height instead of `cv::Size`
* Add the `Crop` method to `Image`.
* The `SelfieVerifier` returns `SelfieVerifierState::ConfirmingFace` when the face circle is green.
* The `SelfieVerifier` returns `SelfieVerifierState::Dark` when the picture is too dark.
