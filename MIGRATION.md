# Migration


## Update to the version 2.0.21 (RecogLib 3.8.1)


### Signature

Because signature can be too big to fit URL parameters, should now be sent as second file in multipart body. If you don't use multipart body, you can append signature to raw data content of raw byte body. 

**Sample request** - Signature added to the end of the body of the message

```swift
func sendImageWithSignature(imageData: Data, signature: String) {
    let urlString = "https://your-server/sample?country=&expectedSampleType=DocumentPicture&documentCode=&pageCode=&role="
    guard let url = URL(string: urlString) else { return }
    
    var httpBodyData = imageData
    
    // Append the signature data to the imageData
    if let signatureData = signature.data(using: .utf8) {
        httpBodyData.append(signatureData)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    request.setValue("\(httpBodyData.count)", forHTTPHeaderField: "Content-Length")
    request.httpBody = httpBodyData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error { return }
        if let data = data { return }
    }
    task.resume()
}
```



### NFC document reading support



#### New SDK method `SelectProfile`

There is new  `SelectProfile` method in interface. This should be called before verifier initialization.
If no profile is selected (no SelectProfile called), default profile is used. Profiles (names) are defined on backend.
The return value indicates whether the profile was successfully selected.


```swift

let profileSelected = ZenidSecurity.selectProfile(name: profileName)

```

Example:
```swift

ZenidSecurity.selectProfile(name: "") // default profile
ZenidSecurity.selectProfile(name: "NFC") // NFC profile


```



#### New files/models

New file `mrz.traineddata` is required by `DocumentVerifier`. To conserve the size of distribution, customers might opt out from having this file, if they also disable NFC validator on their backend. (If NFC validator is disabled, document verifier will load even with mrz.traineddata missing)

New file `face_segmentation.tflite.bin` is required by SelfieLivenessVerifier



#### DocumentVerifier

Added new methods related to NFC document reading support

| method | result  | comment |
| ------ | ------- | ------- |
| getNfcKey() | String? | After taking a picture and processing the corresponding side of the document with the MRZ zone,  it returns the code needed to enable communication with the NFC chip |
| getMrzFields() | MrzFields? | After taking a picture and processing the corresponding side of the document with the MRZ zone, it returns a structure with the items needed to calculate the code required to enable communication with the NFC chip |
| processNfc(jsonData: String?, status: NfcStatus) | | Sends the data read by NFC to the SDK for processing. |
| getState() | DocumentVerifierState? | A method that returns the current state of the document being verified. |
| getSignedImage() | ImageSignature? | Returns the last processed image and its signature. |
| getNfcValidatorSettings() | DocumentVerifierNfcValidatorSettings | Returns the NFC validator settings read from the backend. |
| getDocumentResult(orientation: UIInterfaceOrientation) | DocumentResult? | A method that returns the current result of the document being verified. |
| getSettings() | DocumentVerifierSettings | A method that returns the current settings of the document verifier. |



#### Remove of attributes from struct DocumentVerifierSettings

Some of the settings that used to be parameters of document verifier are now handled by profiles on backend and can no longer be passed to the verifier directly.

Removed attributes `specularAcceptableScore`, `documentBlurAcceptableScore` and `readBarcode` from struct `DocumentVerifierSettings`



### SelfieVerifier

New method `GetSettings()`

| method | result  | comment |
| ------ | ------- | ------- |
|  GetSettings() | SelfieVerifierSettings | | 




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
