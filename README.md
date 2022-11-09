
# RecogLib
Recoglib is a library that lets you recognize and categorize a stream of pictures for specific document types.

## Migration

### From version TODO
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

## Document types
Recoglib is capable of recognizing types that include:
- Identity card
- Driving license
- Passport
- Gun license
- Residency permit
- European Health Insurance Card
- Holograms
- Selfie (human face picture)
- Face liveness
- EU VISA

## Configuration management
For compilation, running and deployment of the application following tools are required. Newer versions of the tools should work, these were tested to work and used during the development:

- Hardware:
    - iOS device with camera for testing
    - macOS device for development
- Software (required for development and deployment):
    - macOS 10.15
    - Xcode 12
    - Swift 5.3
    - iOS 11.0

## Installation

### Statically link the frameworks
Link your project against RecogLib.xcframework and LibZenid.xcframework frameworks 

Go to your project and click on the `Project detail -> General` and under `Embeded binaries` add `RecogLib_iOS.xcframework` and `LibZenid_iOS.xcframework`. Both framework have to be in the `Embedded Binaries` and `Linked Frameworks and Libraries` section.


### Installation with SPM

1. Open your Xcode project.
2. Add remote package dependency https://github.com/ZenIDTeam/ZenID-ios.git
3. In your app target, General tab add **LibZenid_iOS** and **Recoglib_iOS** frameworks 

## Authorization
The SDK has to be authorized, otherwise it is not going to work. 

1. Contact your manager and get information of initSDK API Endpoint and access to the ZenID system where you have to set your bundle ids.
2. Fetch your challenge token from SDK:

```swift
import RecogLib_iOS.CZenidSecurityWrapper

let challengeToken = ZenidSecurity.getChallengeToken()
```
3. Send the `challengeToken` to the initSDK API Endpoint mentioned earlier.
4. Use response token, returned from initSDK API Endpoint, to initialize the SDK:
```swift
let responseToken = ... // backend response - initSDK API Endpoint
let success = ZenidSecurity.authorize(responseToken: responseToken)
```
5. Do not forget to check returned value of `authorize(responseToken:)` method. If it is true, the SDK has been successfully initialised and is ready to be used, otherwise response token is not valid.

## Models
You can choose which models (documents (CZ, SK, ...), selfie, faceliveness) you want to support.
You can find all models available in the `Models` folder in the root of this repository.

If you want to support Selfie, add/link this folder and all files included: `Models/face` into your Xcode project.

If you want to support Faceliveness, add/link this folder and all files included: `Models/face` into your Xcode project.

If you want to support Documents, such as ID, Passport and so on, or different countries, follow instructions below:
Supported countries: AT, BG, CZ, DE, EU, HR, HU, IT, PL, SK, UA

1. You can find all models for documents grouped by countries in the `Models/documents` folder.
2. Choose which countries do you want to support.
3. Optionally, you can remove unnecessary files in those folders, such as `GUN` files if you do not want to scan/recognize these kinds of documents.
4. Link/add all selected folders with your Xcode project.

## Usage
The SDK provides two options how to handle the scanning process. First of them is lightweight, where everything is provided to you and you can have running code with the logic and UI in just a couple lines of code. Second of them is more complicated where you have to implement everything from the scratch by yourself if needed. Let's have a look at those options. 

## Usage - Lightweight
### DocumentController
Use `DocumentController` for scanning documents. You can configure the behaviour and also build custom UI based on the delegate of the controller if needed or you can just use our built-in UI that is provided. 

```swift
// Configuration
let documentControllerConfig = DocumentControllerConfiguration(
    showVisualisation: true,
    showHelperVisualisation: true, // Enables text information rendering
    showDebugVisualisation: false, // Enables debug visualisation rendered directly to camera feed
    dataType: .picture,
    role: .Idc,
    country: .Cz,
    page: .Front,
    code: nil,
    documents: nil,
    settings: nil
)
// Controller
let camera = Camera()
Let cameraView = CameraView()
let documentController = DocumentController(camera: camera, view: cameraView, modelsUrl: URL.modelsDocuments)
documentController?.delegate = self

```
You should always keep one instance of `Camera`, even when you have more controllers (such as SelfieController, FacelivenessController, DocumentController).

Add the `CameraView` into your view hierarchy in order to see the camera's UI and live feed.

You can pass role, country, page, and code if you want to scan only one document. If you need to scan more than one document use `documents` field to pass an array of allowed documents.

You can turn off all visualisations by setting the `showVisualisation: false`. After that you are free to build your own UI. 


The delegate of the controller is following:
```swift
public protocol DocumentControllerDelegate: AnyObject {
    func controller(_ controller: DocumentController, didScan result: DocumentResult)
    func controller(_ controller: DocumentController, didRecord videoURL: URL)
    func controller(_ controller: DocumentController, didUpdate result: DocumentResult)
}

```
You can implement the delegate to be able to receive a message when scanning was successful or when the state of the scan has been changed.
The `didUpdate` method could be used for building your custom UI. The method is called every single time when there is an update of the state of scanning process.

### FacelivenessController 
Use `FacelivenessController` for scanning face. You can configure the behaviour and also build custom UI based on the delegate of the controller if needed or you can just use our built-in UI that is provided. 

```swift
// Configuration
let documentControllerConfig = FacelivenessControllerConfiguration(
    showVisualisation: true,
    showHelperVisualisation: true,
    showDebugVisualisation: false,
    dataType: .picture,
    isLegacy: false
)
// Controller
let camera = Camera()
Let cameraView = CameraView()
let facelivenessController = FacelivenessController(camera: camera, view: contentView, modelsUrl: URL.modelsFolder.appendingPathComponent("face"))
facelivenessController?.delegate = self

```
You should always keep one instance of `Camera`, even when you have more controllers (such as SelfieController, FacelivenessController, DocumentController).

Add the `CameraView` into your view hierarchy in order to see the camera's UI and live feed.

You can turn off all visualisations by setting the `showVisualisation: false`. After that you are free to build your own UI. 


The delegate of the controller is following:
```swift
public protocol FacelivenessControllerDelegate: AnyObject {
    func controller(_ controller: FacelivenessController, didScan result: FaceLivenessResult)
    func controller(_ controller: FacelivenessController, didRecord videoURL: URL)
    func controller(_ controller: FacelivenessController, didUpdate result: FaceLivenessResult)
}

```
You can implement the delegate to be able to receive a message when scanning was successful or when the state of the scan has been changed.
The `didUpdate` method could be used for building your custom UI. The method is called every single time when there is an update of the state of scanning process.

### SelfieController 
Use `SelfieController` for scanning face. You can configure the behaviour and also build custom UI based on the delegate of the controller if needed or you can just use our built-in UI that is provided. 

```swift
// Configuration
let documentControllerConfig = SelfieControllerConfiguration(
    showVisualisation: true,
    showHelperVisualisation: true,
    showDebugVisualisation: false,
    dataType: .picture
)
// Controller
let camera = Camera()
Let cameraView = CameraView()
let selfieController = SelfieController(camera: camera, view: contentView, modelsUrl: URL.modelsFolder.appendingPathComponent("face"))
selfieController?.delegate = self

```
You should always keep one instance of `Camera`, even when you have more controllers (such as SelfieController, FacelivenessController, DocumentController).

Add the `CameraView` into your view hierarchy in order to see the camera's UI and live feed.

You can turn off all visualisations by setting the `showVisualisation: false`. After that you are free to build your own UI. 


The delegate of the controller is following:
```swift

public protocol SelfieControllerDelegate: AnyObject {
    func controller(_ controller: SelfieController, didScan result: SelfieResult)
    func controller(_ controller: SelfieController, didRecord videoURL: URL)
    func controller(_ controller: SelfieController, didUpdate result: SelfieResult)
}

```
You can implement the delegate to be able to receive a message when scanning was successful or when the state of the scan has been changed.
The `didUpdate` method could be used for building your custom UI. The method is called every single time when there is an update of the state of scanning process.


## Usage - From Scratch
You are free to implement everything from the scratch, without use our controller classes. The SDK provides three classes for you: `DocumentVerifier`, `SelfierVerifier`, and `FacelivenessVerifier`.
Example of an implementation from scratch [PureVerifierViewController.swift(./ZenIDDemo/Controller/PureVerifierViewController.swift)]

### `DocumentVerifier`
Recoglib comes with `DocumentVerifier` that makes it really easy to use recoglib in your project.

1. Recognizing only one specific document
First you initialize `DocumentVerifier` with expected role, country, page and language.
For example, Front side of Czech Identity card looks like this.
```Swift
let verifier = DocumentVerifier(role: .Idc, country: .Cz, page: .Front, language: .Language)
```

2. Recognizing multiple predefined documents
Alternativally you can initialize `DocumentVerifier` with `DocumentsInput` that needs array of `Document` structures. 
`Document` structure is a structure that consists of `role: DocumentRole`, `country: Country`, `page: PageCode`, and `DocumentCode`.

For example, if you want to scan Front side of Czech Identity card and Front side of Slovak driving license the setup looks like this.
```swift
let documentsInput = DocumentsInput(documents: [
    Document(role: .Idc, country: .Cz, page: .Front, code: nil),
    Document(role: .Drv, country: .Sk, page: .Front, code: nil)
])
let verifier = DocumentVerifier(input: documentsInput, language: .Czech)
```

3. Recognizing multiple undefined documents 
The parameters of `DocumentVerifier` initializer are optional, you can always pass nil value. 

For example, if you want to scan all documents available, just pass nil to every parameter.
```swift
let verifier = DocumentVerifier(role: nil, country: nil, page: nil, language: .Language)
```

For example, if you want to scan all Czech documents available, just pass nil to every parameter except `country`, that will be `Czech`.
```swift
let verifier = DocumentVerifier(role: nil, country: .Cz, page: nil, language: .Language)
```

#### Models
You have to load models that you would like to support.
URL is the path to your folder that contains files or other folders, such as CZ, SK, etc. You have to pass url that is a folder, not a single file. 
```swift
let url = Bundle.main.bundleURL.appendingPathComponent("Models/documents")
if let models = DocumentVerifierModels(url: url) {
    verifier.loadModels(models)
}
```

#### Verifier Settings
You can tune a couple of parameters of document verifier. Each initializer has optional `settings` parameter.
```swift
let settings = DocumentVerifierSettings(
    specularAcceptableScore: 50,
    documentBlurAcceptableScore: 50,
    timeToBlurMaxToleranceInSeconds: 10,
    showAimingCircle: false,
    drawOutline: true,
    readBarcode: true
)
```
```swift
specularAcceptableScore
```
- default: 50
- range: <0; 100>
```swift
documentBlurAcceptableScore
```
- default: 50
- range: <0; 100>
```swift
timeToBlurMaxToleranceInSeconds
```
- default: 10
- range: <0; undefined)
```swift
showAimingCircle
```
- default: False
```swift
drawOutline
```
- default: True
```swift
readBarcode
```
- default: True

```swift
let verifier = DocumentVerifier(role: .Idc, country: .Cz, page: .Front, language: .Language, settings: settings)
```

Note that properties `role`, `country`,  `page` , an `language` are public and can be changed whenever you like.


Than you define the `func captureOutput(_: ,didOutput: ,from:)` delegate method declared in `AVCaptureVideoDataOutputSampleBufferDelegate`
```swift
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Recoglib magic happens here
    }
}
```
Lastly call the `verify(buffer: )` method of `DocumentVerifier`. Please note this delegate method **is called from background thread**. If you desire to update your view from this method, you **need** to do so from the main thread as shown below.
```swift
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let result = verifier.verify(buffer: sampleBuffer)
        DispatchQueue.main.async {
            self.updateView(with: result)
        }
    }
}
```
Alternatively you can use the `verifyImage(imageBuffer: )` with CVImageBuffer of media data as shown below.
```swift
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let result = verifier.verifyImage(imageBuffer: pixelBuffer)
        DispatchQueue.main.async {
            self.updateView(with: result)
        }
    }
}
```

#### Draw renderables
In case you want to add an information layer with objects that the verifier has detected, you can use the `verifier.getRenderCommands(canvasWidth:Int, canvasHeight:Int)` method. This method returns a string representation of the detected objects. This string is converted into a collection of drawable objects implementing `Renderable` protocol using `RenderableFactory.createRenderables(commands: String)`.
The types of renderable objects are the classes `Line`,`Rectangle`,`Circle`,`Ellipse`,`Text`,`Triangle`.

```swift
var previewLayer: AVCaptureVideoPreviewLayer?
var drawingLayer = DrawingLayer()

// Add the custom layers
override func viewDidLoad() {
    super.viewDidLoad()

    if let previewLayer {
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
    }

    view.layer.addSublayer(drawingLayer)
    drawingLayer.frame = view.frame
}

// Get the objects detected in the current frame and render them over the preview layer.
private func drawRenderables(buffer: CMSampleBuffer) {
    guard let size = previewLayer?.frame.size, let commands = verifier.getRenderCommands(canvasWidth: Int(size.width), canvasHeight: Int(size.height))
    else { return }

    DispatchQueue.main.async { [weak self] in
        let renderables = RenderableFactory.createRenderables(commands: commands)
        self?.drawingLayer.setRenderables(renderables)
    }
}

```

#### Models
You have to load models that you would like to support.
URL is the path to a specific file. You have to pass url that is a specific single file, not a folder. 
```Swift
let verifier = SelfieVerifier(...)
let url = Bundle.main.bundleURL.appendingPathComponent("Models/face")
if let models = FaceVerifierModels(url: url) {
    verifier.loadModels(models)
}
```

### Face liveness verifier
You can use  `FaceLivenessVerifier` to verify face liveness from short video. Human faces are to be identified in video frames.
Interface is very similar to  `DocumentVerifier`, first you initialize `FaceLivenessVerifier` and then call the `verify(buffer: )` or `verifyImage(imageBuffer: )` method in `func captureOutput(_: ,didOutput: ,from:)` .

#### Face liveness step parameters

> Available since version 2.0.12

During the face liveness check, additional parameters (`FaceLivenessStepParameters`) for the current check can be accessed by calling the verifier method `getStepParameters()`
The object is only available during the liveness part of the process. It is null during the preliminary quality check.

Sample:
```Swift
let verifierResult = verifier.verifyImage(imageBuffer: pixelBuffer)
let parameters:FaceLivenessStepParameters = verifier.getStepParameters()
```

The object `FaceLivenessStepParameters` has the following properties:
|Property  |Description  |
|--|--|
| name | Name of the step. It can be `CenteredCheck`, `AngleCheck Left`, `AngleCheck Right`, `AngleCheck Up`, `AngleCheck Down`, `LegacyAngleCheck`, or `SmileCheck`. CenteredCheck requires the user to look at the camera. The AngleCheck steps require the user to turn their head in a specific direction. The LegacyAngleCheck requires the user to turn his head in any direction. It's only used when legacy mode is enabled. SmileCheck requires the user to smile.  |
|totalCheckCount|The total number of the checks the user has to pass, including the ones that were already passed.|
|passedCheckCount |The number of checks the user has passed.|
|hasFailed |Flag that is true if the user has failed the most recent check. After the failed check, a few seconds pass and the check process is restarted - the flag is set to false and passedCheckCount goes back to 0.|
|headYaw|Euler angles of the head in degrees. Only defined if a face is visible. |
|headPitch|Euler angles of the head in degrees. Only defined if a face is visible. |
|headRoll|Euler angles of the head in degrees. Only defined if a face is visible. |
|faceCenterX |Coordinates of the center of the face in relative units. Multiply by the width or height of the camera preview to get absolute units. Only defined if a face is visible. |
|faceCenterY |Coordinates of the center of the face in relative units. Multiply by the width or height of the camera preview to get absolute units. Only defined if a face is visible. |
|faceWidth | Size of the face in relative units. Multiply by the width or height of the camera preview to get absolute units. Only defined if a face is visible. |
|faceHeight | Size of the face in relative units. Multiply by the width or height of the camera preview to get absolute units. Only defined if a face is visible. |


#### Models
You have to load models that you would like to support.
URL is the path to a specific file. You have to pass url that is a specific single file, not a folder. 
```Swift
let verifier = FaceLivenessVerifier(...)
let url = Bundle.main.bundleURL.appendingPathComponent("Models/face")
if let models = FaceVerifierModels(url: url) {
    verifier.loadModels(models)
}
```

### Holograms
You can use  `DocumentVerifier` to detect 2D holograms on cards.
To do that, you can use this object the same way like to detect documents and call method `beginHologramVerification` and endHologramVerification. You can record video for selfie and faceliveness, however, there is no need to call any methods on their verifiers.

Detection logic in `captureOutput(_: ,didOutput: ,from:)` is almost the same but in case of holograms you can easily add reconrding video with `VideoWriter` class.
This video can be uploaded to the backend after successful detection of hologram.

### Selfie verifier
You can use  `SelfieVerifier` to verify selfie (human face picture) from short video. Human faces are to be identified in video frames.
Interface is very similar to  `DocumentVerifier`, first you initialize `SelfieVerifier` and then call the `verify(buffer: )` or `verifyImage(imageBuffer: )` method in `func captureOutput(_: ,didOutput: ,from:)`.


#### Auxiliary Images
You can get all images that have been taken during the Faceliveness process.
```Swift
let verifier = FaceLivenessVerifier(...)
let info = verifier.getAuxiliaryInfo()
for imageData in info.images {
    let image = UIImage(data: imageData)
    // You can use the image
}
for metadata in info.metadata {
    // You can use the image metadata
}
```

#### Legacy mode
Faceliveness verifier has two modes. First is the new one and second one is the legacy. You can choose which one you want by using FaceLivenessVerifierSettings in constructor or `update` method of the verifier class. Moreover, you can specify the qualify of those pictures. Be default the legacy mode is disabled.

Constructor method
```Swift
let settings = FaceLivenessVerifierSettings(
    isLegacyModeEnabled: true,
    maxAuxiliaryImageSize: 300,
    visualizerVersion: 1
)
let verifier = FaceLivenessVerifier(language: .Czech, settings: settings)
```

Update method
```Swift
let verifier = FaceLivenessVerifier(...)
...
let settings = FaceLivenessVerifierSettings(
    isLegacyModeEnabled: false,
    maxAuxiliaryImageSize: 300,
    visualizerVersion: 1
)
verifier.update(settings: settings)
let info = verifier.getAuxiliaryInfo()
```
 
### Result
The returning value of the `verify()` or `verifyImage(imageBuffer: )` methods is a struct of type `DocumentResult` for documents, `HologramResult` for holograms or `FaceResult` for face liveness.

It contains all the information found describing currently analysed document/face.

`DocumentResult` contains following values:
- `state` - state of currently analysed image (e.g. `NoMatchFound`, `Blurry` or `ReflectionPresent` etc.)
- `code` - version of a document (e.g. new or old version of Slovakia identity card). This attribute can be `nil` when state is equal to `NoMatchFound`
- `role` - specified type of a document
- `country` - specified origin country of a document
- `page` - specified page
- `signature` - signature when state is OK

Hologram result contains state of currently analysed image.
`HologramResult.state`  can be `center`, `tiltLeftAndRight`, `tiltUpAndDown` and finally  `ok`

Selfie detection result contains state of currently analysed image.
`SelfieResult.state` can be `NoFaceFound`, `Blurry`, `Dark`, `ConfirmingFace` and finally `Ok`

Face liveness detection result contains state of currently analysed image.
`FaceLivenessResult.state` can be `LookAtMe`, `TurnHead`, `Smile`, `Blurry`, `Dark` and finally  `Ok`

### Signature
The SDK now generates a signature for the snapshots it takes. The backend uses the signature to verify picture origin and integrity. The signature lets you upload the final frame instead of the whole video for verification. The SDK only generates a signature when the result state is OK. 

The SDK provides the signature as an attribute inside of the result objects of verifiers, such as `DocumentResult`, `FaceLivenessResult`, and `SelfieResult`. Hologram does not support the signature. 

This is what `ImageSignature` structure looks like:
```swift
struct ImageSignature {
    let image: Data
    let signature: String
}
```
Where the `image` attribute is binary data of the image that contains the SDK signature. You have to send this binary data to the backend if you want to have your signature to be validated. The `signature` attribute is a string that represents the signature itself that you should send to the backend in your investigation sample HTTP REST call. 

### Open Source

Zenid is powered by Open Source libraries.

 * AHEasing (WTFPL)
 * Catch2 (Boost Software License 1.0)
 * cppcodec (MIT License)
 * cvui (MIT License)
 * cxxopts (MIT License)
 * fmt (MIT License)
 * gmath (MIT License)
 * hedley (Creative Commons Zero v1.0 Universal)
 * imgui (MIT License)
 * implot (MIT License)
 * JSON for Modern C++ (Creative Commons Zero v1.0 Universal)
 * Magic Enum C++ (MIT License)
 * nameof (MIT License)
 * OpenCV  (Apache License 2.0)
 * PicoSHA2 (MIT License)
 * plusaes (Boost Software License 1.0)
 * Rapidcsv (BSD 3-Clause license)
 * Tensorflow Lite (Apache License 2.0)
 * TooJpeg (zlib License)
