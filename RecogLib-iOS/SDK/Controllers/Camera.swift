import AVFoundation
import Foundation
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
    
    private(set) var previewLayer: AVCaptureVideoPreviewLayer?

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.ZenID.cameraCaptureQueue")
    
    private var captureDevice: AVCaptureDevice?
    
    private let captureSession = AVCaptureSession()
    
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    
    private var cameraVideoOutput: AVCaptureVideoDataOutput!

    private var takePictureCompletion: ((Swift.Result<Data, Swift.Error>) -> Void)?
    
    public func isCaptureSessionRunning() -> Bool {
        captureSession.isRunning
    }
    
    private var torchShouldBeOn: Bool = false

    func configure(with configuration: CameraConfiguration) throws {
        let captureDevicePosition: AVCaptureDevice.Position = configuration.type == .back ? .back : .front
        let deviceTypes = [AVCaptureDevice.DeviceType.builtInWideAngleCamera]
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                                      mediaType: .video,
                                                                      position: captureDevicePosition)
        captureDevice = deviceDescoverySession.devices.last

        guard let device = captureDevice, setupCameraSession(device) else {
            throw CameraError.notInitialized
        }

        previewLayer = previewLayer ?? AVCaptureVideoPreviewLayer(session: captureSession)

        captureSession.sessionPreset = .high
        
        // Zoom factor is necessary to compensate minimal focus distance by newer iphones (13 Pro +)
        if #available(iOS 15.0, *) {
            Camera.setRecommendedZoomFactor(for: device)
        }
    }

    func start() {
        guard !captureSession.isRunning else { return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

    func stop() {
        torchShouldBeOn = false
        setTorch(isOn: false)
        guard captureSession.isRunning else { return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.captureSession.stopRunning()
        }
    }

    func takePicture(completion: @escaping (Swift.Result<Data, Swift.Error>) -> Void) {
        guard captureDevice != nil else {
            return completion(.failure(CameraError.notInitialized))
        }
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            return completion(.failure(CameraError.notInitialized))
        }
        takePictureCompletion = completion
        cameraPhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }

    
    /// Set video preview layer orientation.
    ///
    /// - Parameter orientation: Optional parameter to force orientation.
    public func setOrientation(orientation: UIInterfaceOrientation? = nil) {
        let uiOrientation = orientation ?? { if #available(iOS 15.0, *) {
                UIApplication
                    .shared
                    .connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .last?.windowScene?.interfaceOrientation ?? .portrait
            } else if #available(iOS 13.0, *) {
                UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .last { $0.isKeyWindow }?
                    .windowScene?.interfaceOrientation ?? .portrait
            } else {
                UIApplication.shared.statusBarOrientation
            }
        }()
        
        switch uiOrientation {
        case .portrait:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        case .landscapeLeft:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        case .portraitUpsideDown:
            previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
        default: break
        }

        if let previewOrientation = previewLayer?.connection?.videoOrientation {
            captureSession.connections.forEach { connection in
                if connection.videoOrientation != previewOrientation {
                    connection.videoOrientation = previewOrientation
                }
            }
        }

        DispatchQueue.main.async { [weak self] in
            self?.setTorch()
        }
    }
    
    /// Set camera torch on or off.
    ///
    /// - Parameter isOn: When `true` then camera torch is set on. If `nil` then used last state.
    func setTorch(isOn: Bool? = nil) {
        let isOn = isOn ?? torchShouldBeOn
        guard let captureDevice, captureDevice.hasTorch else { return }
        
        torchShouldBeOn = isOn
        
        let torchMode: AVCaptureDevice.TorchMode = isOn ? .on : .off
        guard captureDevice.torchMode != torchMode else { return }

        do {
            try captureDevice.lockForConfiguration()
            ApplicationLogger.shared.Debug(isOn ? "Torch is enabled" : "Torch is disabled")
            captureDevice.torchMode = torchMode
            captureDevice.unlockForConfiguration()
        } catch {
            captureDevice.unlockForConfiguration()
            ApplicationLogger.shared.Error(String(format: "Torch failed: %@", error.localizedDescription))
        }
    }

    
    /// Convert current capture format into rectangle size.
    ///
    /// - Returns: Rectangle size.
    func getCurrentResolution() -> CGSize {
        guard let formatDescription = captureDevice?.activeFormat.formatDescription else { return .zero }
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
        return CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
    }
    
    /// Convert `AVCaptureDevice.Format` into rectangle size and reflect UI orientation.
    ///
    /// - Parameter format: AV capture format.
    /// - Returns: Rectangle size.
    func getFormatResolution(_ format: AVCaptureDevice.Format) -> CGSize {
        var resolution = CGSize(width: 0, height: 0)
        let portraitOrientation = (UIScreen.main.bounds.height > UIScreen.main.bounds.width)
        let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
        let resolution = if portraitOrientation {
            CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
        } else {
            CGSize(width: CGFloat(dimensions.height), height: CGFloat(dimensions.width))
        }
        return resolution
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        defer { takePictureCompletion = nil }
        
        if let error {
            takePictureCompletion?(.failure(error))
        } else if let data = photo.fileDataRepresentation() {
            takePictureCompletion?(.success(data))
        }
    }
}

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        delegate?.cameraDelegate(camera: self, onOutput: sampleBuffer)
    }
}

private extension Camera {
    
    func setupCameraSession(_ device: AVCaptureDevice) -> Bool {
        guard let input = try? AVCaptureDeviceInput(device: device) else { return false }

        previewLayer?.videoGravity = Defaults.videoGravity

        captureSession.beginConfiguration()

        captureSession.inputs.forEach { captureSession.removeInput($0) }
        captureSession.outputs.forEach { captureSession.removeOutput($0) }

        cameraPhotoOutput = AVCapturePhotoOutput()
        cameraVideoOutput = AVCaptureVideoDataOutput()

        captureSession.addInput(input)
        captureSession.addOutput(cameraPhotoOutput)
        cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA] as [String: Any]
        cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)
        captureSession.addOutput(cameraVideoOutput)

        captureSession.commitConfiguration()

        return true
    }
    
}

// This extension include all methods necessary for zoom compensation to fix minimal focus distance on newer devices.
public extension Camera {
    
    /// Zoom video feed to compensate for minimal focus distance.
    /// - Parameters:
    ///   - device: Device that is compensated.
    ///   - subjectSize: Minimal object size to focus on in milimeters. (default is 110mm)
    @available(iOS 15.0, *)
    static func setRecommendedZoomFactor(for device: AVCaptureDevice, subjectSize: Float = 110) {
        let deviceMinimumFocusDistance = Float(device.minimumFocusDistance)
        guard deviceMinimumFocusDistance != -1 else { return }
        
        let deviceFieldOfView = device.activeFormat.videoFieldOfView
        let minimumSubjectDistance = minimumSubjectDistance(fieldOfView: deviceFieldOfView,
                                                            minimumSubjectSize: subjectSize,
                                                            previewFillPercentage: 1)
        if minimumSubjectDistance < deviceMinimumFocusDistance {
            let zoomFactor = deviceMinimumFocusDistance / minimumSubjectDistance
            do {
                try device.lockForConfiguration()
                device.videoZoomFactor = CGFloat(zoomFactor)
                device.unlockForConfiguration()
            } catch {
                print("Could not lock for configuration: \(error)")
            }
        }
    }
    
    /// Given the camera horizontal field of view, we can compute the distance (mm) to make a code
    /// of minimumCodeSize (mm) fill the previewFillPercentage.
    ///
    /// - Parameters:
    ///   - fieldOfView: Field of view in degree.
    ///   - minimumSubjectSize: Minimal subject size to focus on in milimeters.
    ///   - previewFillPercentage: How much it shall fill the frame.
    /// - Returns: Required distance as fraction.
    static private func minimumSubjectDistance(
        fieldOfView: Float,
        minimumSubjectSize: Float,
        previewFillPercentage: Float
    ) -> Float {
        let radians = degreesToRadians(fieldOfView / 2)
        let filledCodeSize = minimumSubjectSize / previewFillPercentage
        return filledCodeSize / tan(radians)
    }
    
    /// Convert degrees to radians.
    ///
    /// - Parameter degrees: Value representing degrees.
    /// - Returns: Calculated radians.
    static private func degreesToRadians(_ degrees: Float) -> Float {
        return degrees * Float.pi / 180
    }
    
}
