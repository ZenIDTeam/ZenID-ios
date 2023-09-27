## Migration


### Update to release version 2.0.21 (RecogLib 3.8.1)


#### Signature

Signature should now be sent as second file in multipart body. If you don't use multipart body, you can append signature to raw data content of raw byte body. Signature can be too big to fit URL parameters.

#### SelectProfile
There is now `SelectProfile` method in interface. This should be called before verifier ... TBD
If no profile is selected (no SelectProfile called), default profile is used.

#### New files/models

New file `mrz.traineddata` is required by `DocumentVerifier`. To conserve the size of distribution, customers might opt out from having this file, if they also disable NFC validator on their backend. (If NFC validator is disabled, document verifier will load even with mrz.traineddata missing)

New file `face_segmentation.tflite.bin` is required by SelfieLivenessVerifier

#### Remove of settings for DocumentVerifier
Some of the settings that used to be parameters of document verifier are now handled by profiles on backend and can no longer be passed to the verifier directly.

Removed attributes `specularAcceptableScore`, `documentBlurAcceptableScore` and `readBarcode` from struct `DocumentVerifierSettings`

#### SelfieVerifier
- new method GetSettings()
SelfieVerifierSettings can be obtained by calling GetSettings() method of SelfieVerifier.



## Older versions


### From version 2.0.14 (RecogLib 2.11.3)
The default value of parameter *drawOutline* in DocumentVerifierSettings changed from *false* to *true*


### To the version 2.0.0
When calling `verifyImage` method of all verifiers, pass the orientation of the device. There is no need to transform/map the orientation anymore. 

### To the version 1.9.0
1. We removed `Models/face/haarcascade_frontalface_alt2.xml` and `Models/face/lbfmodel.yaml.bin`. The models were replace by new models. Please do not use an individual file anymore. Use the `Models/face` folder to load models for Selfie or Faceliveness. Check the Faceliveness Verifier sections for more information.

### To the version 1.7.0
1. We removed models from RecogLib framework, therefore, you can now configure which models you want to use by yourself. It will help you to reduce the final size of your app binary.

How to load models by yourself?
Document Verifier:
```Swift
let verifier = DocumentVerifier(...)
let url = Bundle.main.bundleURL.appendingPathComponent("documents")
if let models = DocumentVerifierModels(url: url) {
    verifier.loadModels(models)
}
```

Selfie Verifier:
```Swift
let verifier = SelfieVerifier(...)
let url = Bundle.main.bundleURL.appendingPathComponent("haarcascade_frontalface_alt2.xml")
if let models = FaceVerifierModels(url: url) {
    verifier.loadModels(models)
}
```

Faceliveness Verifier:
```Swift
let verifier = FaceLivenessVerifier(...)
let url = Bundle.main.bundleURL.appendingPathComponent("lbfmodel.yaml.bin")
if let models = FaceVerifierModels(url: url) {
    verifier.loadModels(models)
}
```

Do not forget to add/link models into your Xcode project. Check out the documentation below for instructions.

2. We changed format of RecogLib and LibZenid frameworks to XCFrameworks. Please, unlink your old RecogLib and LibZenid frameworks from your Xcode project add link the new ones. That means `LibZenid_iOS.xcframework` and `RecogLib_iOS.xcframework`, you do not have to change anything else.
