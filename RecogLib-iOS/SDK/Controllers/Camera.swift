import Foundation
import AVFoundation
import UIKit

struct CameraConfiguration {
    public let type: CameraType
}

enum CameraError: Error {
    case notInitialized
}

enum CameraType {
    case front
    case back
}

public enum DataType {
    case picture
    case video
}

protocol CameraDelegate: AnyObject {
    func cameraDelegate(camera: Camera, onOutput sampleBuffer: CMSampleBuffer)
}

public final class Camera: NSObject {
    weak var delegate: CameraDelegate?
    private(set) var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    private var cameraVideoOutput: AVCaptureVideoDataOutput!
    
    private var takePictureCompletion: ((Swift.Result<Data, Swift.Error>) -> Void)?
    
    public override init() {
        super.init()
    }
    
    func configure(with configuration: CameraConfiguration) throws {
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
    
    func start() {
        if captureSession.isRunning {
            return
        }
        captureSession.startRunning()
    }
    
    func stop() {
        if !captureSession.isRunning {
            return
        }
        captureSession.stopRunning()
    }
    
    func takePicture(completion: @escaping (Swift.Result<Data, Swift.Error>) -> Void) {
        guard captureDevice != nil else {
            completion(.failure(CameraError.notInitialized))
            return
        }
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            completion(.failure(CameraError.notInitialized))
            return
        }
        takePictureCompletion = completion
        cameraPhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    func setOrientation(orientation: UIDeviceOrientation) {
        switch UIDevice.current.orientation {
        case .portrait:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        case .landscapeLeft:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        case .portraitUpsideDown:
            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
        default: break
        }
        
        if #available(iOS 13.0, *) {
            for connection in captureSession.connections {
                connection.videoOrientation = previewLayer.connection?.videoOrientation ?? .portrait
            }
        }
    }
    
    func setTorch(isOn: Bool) throws {
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

    func getCurrentResolution() -> CGSize {
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
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }
        
        cameraPhotoOutput = AVCapturePhotoOutput()
        cameraVideoOutput = AVCaptureVideoDataOutput()
        
        captureSession.addInput(input)
        captureSession.addOutput(cameraPhotoOutput)
        cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA] as [String : Any]
        cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)
        captureSession.addOutput(cameraVideoOutput)

        captureSession.commitConfiguration()

        return true
    }
}
