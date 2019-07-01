# RecogLib
Recoglib is a library that lets you recognize and categorize a stream of pictures for specific document types. This library is built around the popular opensource framework `OpenCV`

## Document types
Recoglib is capable of recognizing types that include:
- Identity card
- Driving license
- Passport

## Usage
Recoglib is built to be used with `AVCaptureSession`.

### 1) Configure `AVCaptureSession`
Here is a typical example of implementing `AVCaptureSession`. First initialize `AVCaptureSession` object and start batch configuration by calling `beginConfiguration` method.
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

### 2) Configure `DocumentVerifier`
Recoglib comes with `DocumentVerifier` that makes it really easy to use recoglib in your project.
First you initialize `DocumentVerifier` with expected role, country and page.
```
let verifier = DocumentVerifier(role: .Idc, country: .Cz, page: .Front)
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
Alternatively if you have specific frame of the picture that you wish to be verified instead, you can use the `verify(buffer: , displayWidth:, displayHeight: , frameHeight: )` as shown below.
```
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // due to incorrect camera orientation the width has to be switched with height
        let result = verifier.verify(buffer: sampleBuffer, displayWidth: frames.cameraHeight, displayHeight: frames.cameraWidth, frameHeight: frames.frameWidth)
        DispatchQueue.main.async {
            self.updateView(with: result)
        }
    }
}
```
### 3) Result
The returning value of the `verify()` methods is a struct of type `MatcherResult`. It contains all the information found describing currently analysed document.

It contains following values:
- `role` - represents the type of a document (e.g. whether it is identity card, driving licence or a passport)
- `country` - origin country of a document
- `code` - version of a document (e.g. new or old version of slovakia identity card)
- `page` - whether it is a front or back of a document
- `state` - state is the analysed image (e.g. `NoMatchFound`, `Blurry` or `ReflectionPresent` etc.)

