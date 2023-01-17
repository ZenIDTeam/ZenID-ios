import AVFoundation
import Foundation
import UIKit

public struct CameraConfiguration {
    public enum OutputVariant {
        case photo
        case qrCode
    }

    public let type: CameraType
    public let variant: OutputVariant

    public init(type: CameraType, variant: OutputVariant = .photo) {
        self.type = type
        self.variant = variant
    }
}

public enum CameraError: Error {
    case notInitialized
    case invalidVariant
}

public enum CameraType {
    case front
    case back
}

public enum DataType {
    case picture
    case video
}

public protocol CameraDelegate: AnyObject {
    func cameraDelegate(camera: Camera, onOutput sampleBuffer: CMSampleBuffer)
}

public final class Camera: NSObject {
    weak var delegate: CameraDelegate?
    public private(set) var previewLayer: AVCaptureVideoPreviewLayer?

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput?
    private var metadataOutput: AVCaptureMetadataOutput?
    private var cameraVideoOutput: AVCaptureVideoDataOutput?
    private var variant: CameraConfiguration.OutputVariant = .photo

    private var takePictureCompletion: ((Swift.Result<Data, Swift.Error>) -> Void)?
    public var takeQrCodeCompletion: ((AVMetadataMachineReadableCodeObject) -> Void)?

    override public init() {
        super.init()
    }

    public func configure(with configuration: CameraConfiguration) throws {
        variant = configuration.variant
        let captureDevicePosition: AVCaptureDevice.Position = configuration.type == .back ? .back : .front
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: captureDevicePosition
        )
        captureDevice = deviceDescoverySession.devices.first

        guard let device = captureDevice, setupCameraSession(device) else {
            throw CameraError.notInitialized
        }
        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        }
    }

    public func start() {
        if captureSession.isRunning {
            return
        }
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

    public func stop() {
        try? setTorch(isOn: false)
        if !captureSession.isRunning {
            return
        }
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.stopRunning()
        }
    }

    public func takePicture(completion: @escaping (Swift.Result<Data, Swift.Error>) -> Void) {
        guard captureDevice != nil else {
            completion(.failure(CameraError.notInitialized))
            return
        }
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            completion(.failure(CameraError.notInitialized))
            return
        }
        guard let cameraPhotoOutput = cameraPhotoOutput else {
            completion(.failure(CameraError.invalidVariant))
            return
        }

        takePictureCompletion = completion
        cameraPhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }

    public func setOrientation(orientation: UIDeviceOrientation) {
        let isTorchOn = captureDevice?.torchMode == .on
        switch UIDevice.current.orientation {
        case .portrait:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        case .landscapeLeft:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        case .portraitUpsideDown:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
        default: break
        }

        if #available(iOS 13.0, *) {
            for connection in captureSession.connections {
                connection.videoOrientation = previewLayer?.connection?.videoOrientation ?? .portrait
            }
        }

        DispatchQueue.main.async { [weak self] in
            if isTorchOn {
                try? self?.setTorch(isOn: true)
            }
        }
    }

    public func setTorch(isOn: Bool) throws {
        guard let device = captureDevice, device.hasTorch else { return }
        guard isOn || device.torchMode != .off else { return }

        let torchMode: AVCaptureDevice.TorchMode = isOn ? .on : .off
        guard device.torchMode != torchMode else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()
            } catch {
                throw error
            }
            device.torchMode = torchMode
        }
        device.unlockForConfiguration()
    }

    public func getCurrentResolution() -> CGSize {
        guard let formatDescription = captureDevice?.activeFormat.formatDescription else {
            return .zero
        }
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
        return CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            takePictureCompletion?(.failure(error))
        } else if let data = photo.fileDataRepresentation() {
            takePictureCompletion?(.success(data))
        }
        takePictureCompletion = nil
    }
}

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.cameraDelegate(camera: self, onOutput: sampleBuffer)
    }
}

private extension Camera {
    func setupCameraSession(_ device: AVCaptureDevice) -> Bool {
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return false
        }

        previewLayer?.videoGravity = Defaults.videoGravity

        captureSession.beginConfiguration()

        // Inputs

        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        captureSession.addInput(input)

        // Outputs

        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }

        switch variant {
        case .photo:
            let cameraPhotoOutput = AVCapturePhotoOutput()
            self.cameraPhotoOutput = cameraPhotoOutput
            captureSession.addOutput(cameraPhotoOutput)

            let cameraVideoOutput = AVCaptureVideoDataOutput()
            cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA] as [String: Any]
            cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)
            self.cameraVideoOutput = cameraVideoOutput
            captureSession.addOutput(cameraVideoOutput)
        case .qrCode:
            let metadataOutput = AVCaptureMetadataOutput()
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureSession.addOutput(metadataOutput)
            self.metadataOutput = metadataOutput
        }

        captureSession.commitConfiguration()

        return true
    }
}

extension Camera: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for data in metadataObjects {
            let transformed = previewLayer?.transformedMetadataObject(for: data) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                takeQrCodeCompletion?(unwraped)
                DispatchQueue.global(qos: .default).async { [weak self] in
                    self?.stop()
                }
            }
        }
    }
}

extension Camera {
    public func getCroppedImageRect(width: Int, height: Int, targetFrame: CGRect) -> CGRect {
        let gravity = Defaults.videoGravity
        switch gravity {
        case .resizeAspect:
            let imageRect = CGRect(x: 0, y: 0, width: width, height: height)
            let layerRect = imageRect.rectThatFitsRect(targetFrame)
            let metadataRect = previewLayer!.metadataOutputRectConverted(fromLayerRect: layerRect)
            let cropRect = metadataRect.applying(CGAffineTransform(scaleX: CGFloat(width), y: CGFloat(height)))
            return cropRect
        case .resizeAspectFill:
            let layerRect = targetFrame
            let metadataRect = previewLayer!.metadataOutputRectConverted(fromLayerRect: layerRect)
            let cropRect = metadataRect.applying(CGAffineTransform(scaleX: CGFloat(width), y: CGFloat(height)))
            return cropRect
        default:
            return .zero
        }
    }

    public func getCroppedPixelBuffer(pixelBuffer: CVPixelBuffer, targetFrame: CGRect) -> CVPixelBuffer? {
        // camera frame size
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)

        // find cropping
        let cropRect = getCroppedImageRect(width: width, height: height, targetFrame: targetFrame)

        // create (cropped) image
        let image = UIImage(pixelBuffer: pixelBuffer, crop: cropRect)
        return image?.toCVPixelBuffer()
    }
}
