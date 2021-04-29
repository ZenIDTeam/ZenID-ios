# RecogLib
Recoglib is a library that lets you recognize and categorize a stream of pictures for specific document types.

## Document types
Recoglib is capable of recognizing types that include:
- Identity card
- Driving license
- Passport
- Holograms
- Selfie (human face picture)
- Face liveness

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
### Link your project against RecogLib and LibZenid frameworks 

Go to your project and click on the `Project detail -> General` and under `Embeded binaries` add `RecogLib_iOS.framework` and `LibZenid_iOS.framework`. Both framework have to be in the `Embedded Binaries` and `Linked Frameworks and Libraries` section.

## Appication settings
In iOS device under Settings -> ZenID is possible to set
### Camera video gravity mode
`Fit` - preserve aspect ratio; fit within layer bounds, this mode corresponds to CENTER_INSIDE in Android, this is default and recommended settings because it generates images with better resolution
`Fill` - preserve aspect ratio; fill layer bounds - CENTER_CROP from Android, data will be cropped to visible part of the image preview. 

### Torch mode
Is useful for hologram detection

## Appication logs
Demo application uses external libraries CocoaLumberjackSwift and ZipArchive to create application logs.
You can get log file(s) through `Logs` button from home screen,
or alternatively directly from device, through USB cable
- Connect your device to your mac
- In Xcode, go to Window -> Devices
- On top-left in the device list, click on the connected device.
- In the main panel, under Installed Apps section, click on the ZenID application.
- At the bottom of the Installed Apps list, click on the gear icon and then Download Container.
- In Finder, right click (show menu) on the saved .xcappdata file and select Show Package Contents
- Log files are saved in /AppData/Library/Caches/Logs/

## Usage
### 1. Configure `AVCaptureSession`
Recoglib is built to be used with AVCaptureSession. Here is a typical example of implementing `AVCaptureSession`. First initialize `AVCaptureSession` object and start batch configuration by calling `beginConfiguration` method.
```
let session = AVCaptureSession()
session.beginConfiguration()
```
Set up the input device that you'd want to receive video stream from. Please note that you'd want mark `mediaType` as `.video` since Recoglib can't deal with any other types of media. Using the mediaType of `.video` **is mandatory**.
```
let input = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
guard let device = input.devices.first, let deviceInput = try? AVCaptureDeviceInput(device: device) else {
    session.commitConfiguration()
    return
}
session.addInput(deviceInput)
```
Next you need to specify a `AVCaptureVideoDataOutputSampleBufferDelegate` which will receive the video stream from the input specified above. To do that, you need to instanciate `AVCaptureVideoDataOutput` and its settings as shown below.

Please note that the whole video stream will be capture **on a background thread** that needs to be specified explicitly.
```
let output = AVCaptureVideoDataOutput()
output.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA] as [String : Any]
let captureQueue = DispatchQueue(label: "Camera_capture_queue")
output.setSampleBufferDelegate(self, queue: captureQueue)
session.addOutput(output)
```
Lastly you need to commit this configuration and start the capturing.
```
session.commitConfiguration()
session.startRunning()
```

### 2. Configure `DocumentVerifier`
Recoglib comes with `DocumentVerifier` that makes it really easy to use recoglib in your project.
First you initialize `DocumentVerifier` with expected role, country, page and language.
Alternativally you can initialize `DocumentVerifier` with acceptableInputJson string and use custom filter to detect any combination of supported documents, for example:

- slovak passport: `acceptableInputJson` = "{\"PossibleDocuments\":[{\"Role\":\"Pas\",\"Country\":\"Sk\"}]}"
- czech back Id: `acceptableInputJson` = "{\"PossibleDocuments\":[{\"Role\":\"Idc\",\"Country\":\"Cz\",\"Page\":\"B\"}]}"
- czech back Id or slovak passport: `acceptableInputJson` = "{\"PossibleDocuments\":[{\"Role\":\"Idc\",\"Country\":\"Cz\",\"Page\":\"B\"},{\"Role\":\"Pas\",\"Country\":\"Sk\"}]}"
- any front page: `acceptableInputJson` = "{\"PossibleDocuments\":[{\"Page\":\"F\"}]}"
- any (supported) document: `acceptableInputJson` = "{}"

Note that properties `role`, `country`,  `page` , `language` and `acceptableInputJson` are public and can be changed whenever you like.
```
let verifier = DocumentVerifier(role: .Idc, country: .Cz, page: .Front, language: .Language) or let verifier = DocumentVerifier(acceptableInputJson: String, language: .Language)
```
Than you define the `func captureOutput(_: ,didOutput: ,from:)` delegate method declared in `AVCaptureVideoDataOutputSampleBufferDelegate`
```
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Recoglib magic happens here
    }
}
```
Lastly call the `verify(buffer: )` method of `DocumentVerifier`. Please note this delegate method **is called from background thread**. If you desire to update your view from this method, you **need** to do so from the main thread as shown below.
```
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
```
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

### 3. Holograms
You can use  `DocumentVerifier` to detect 2D holograms on cards.
To do that, you can use this object the same way like to detect documents and call method `beginHologramVerification`.

Detection logic in `captureOutput(_: ,didOutput: ,from:)` is almost the same but in case of holograms you can easily add reconrding video with `VideoWriter` class.
This video can be uploaded to the backend after successful detection of hologram.

### 4. Selfie verifier
You can use  `SelfieVerifier` to verify selfie (human face picture) from short video. Human faces are to be identified in video frames.
Interface is very similar to  `DocumentVerifier`, first you initialize `SelfieVerifier` and then call the `verify(buffer: )` or `verifyImage(imageBuffer: )` method in `func captureOutput(_: ,didOutput: ,from:)` .

### 5. Face liveness verifier
You can use  `FaceLivenessVerifier` to verify face liveness from short video. Human faces are to be identified in video frames.
Interface is very similar to  `DocumentVerifier`, first you initialize `FaceLivenessVerifier` and then call the `verify(buffer: )` or `verifyImage(imageBuffer: )` method in `func captureOutput(_: ,didOutput: ,from:)` .
 
### 6. Result
The returning value of the `verify()` or `verifyImage(imageBuffer: )` methods is a struct of type `DocumentResult` for documents, `HologramResult` for holograms or `FaceResult` for face liveness.

It contains all the information found describing currently analysed document/face.

`DocumentResult` contains following values:
- `state` - state of currently analysed image (e.g. `NoMatchFound`, `Blurry` or `ReflectionPresent` etc.)
- `code` - version of a document (e.g. new or old version of slovakia identity card). This attribute can be `nil` when state is equal to `NoMatchFound`
- `role` - specified type of a document
- `country` - specified origin country of a document
- `page` - specified page

Hologram result contains state of currently analysed image.
`HologramResult.state`  can be `NoMatchFound`, `TiltLeft`, `RotateClockwise` etc. and finally  `Ok`

Selfie detection result contains state of currently analysed image.
`SelfieResult.state` can be `NoFaceFound`, `Blurry`, `Dark`, `ConfirmingFace` and finally `Ok`

Face liveness detection result contains state of currently analysed image.
`FaceLivenessResult.state` can be `LookAtMe`, `TurnHead`, `Smile` and finally  `Ok`
