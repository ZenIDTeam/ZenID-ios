//
//  Example of an implementation from scratch when you need to implement a custom UI
//
//  Created by Lukáš Gergel
//  Copyright © 2023 Trask, a.s. All rights reserved.
//

import AVFoundation
import Foundation
import RecogLib_iOS
import UIKit

final class PureFaceLivenessVerifierViewController: UIViewController {
    // MARK: - Private properties

    private let verifier: FaceLivenessVerifier

    private(set) var previewLayer: AVCaptureVideoPreviewLayer?
    private(set) var drawingLayer = DrawingLayer()

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.zenid.cameraCaptureQueue")
    private let captureSession = AVCaptureSession()
    private var cameraVideoOutput: AVCaptureVideoDataOutput!

    // MARK: - Init

    init() {
        verifier = .init(language: .English)
        
        super.init(nibName: nil, bundle: nil)

        NotificationCenter.default.addObserver(
            self, selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification, object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadModels(url: .modelsFolder.appendingPathComponent("face"))
        
        guard setupCameraSession() else { return }
        setupVerifier()
        setupUI(with: .default)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setOrientation(orientation: UIDevice.current.orientation)
        start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        verifier.reset()
        stop()
    }

    // MARK: - Public functions

    func start() {
        if captureSession.isRunning {
            return
        }
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

    func stop() {
        if !captureSession.isRunning {
            return
        }
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.stopRunning()
        }
    }

    // MARK: - Private functions

    @objc
    private func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.setOrientation(orientation: UIDevice.current.orientation)
        }
    }

    private func loadModels(url: URL) {
        guard let models = FaceVerifierModels(url: url) else {
            return
        }
        verifier.loadModels(models)
    }

    private func verifyImage(buffer: CMSampleBuffer) {
        let result = verifier.verify(buffer: buffer)
        // process the verifier result here
        if result?.isOk == true {
            let auxiliaryInfo = verifier.getAuxiliaryInfo()
            let images = auxiliaryInfo?.images ?? []
            print("Selfie is ready with \(images.count) images.")
            
            stop()
            verifier.reset()
        }
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
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension PureFaceLivenessVerifierViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        verifyImage(buffer: sampleBuffer)
        drawRenderables(buffer: sampleBuffer)
    }
}

// MARK: - UI setup

extension PureFaceLivenessVerifierViewController {
    func setupUI(with configuration: Configuration) {
        if let previewLayer {
            view.layer.addSublayer(previewLayer)
            previewLayer.frame = view.frame
        }
        view.layer.addSublayer(drawingLayer)
        drawingLayer.frame = view.frame
    }
}

// MARK: - Verifier setup

extension PureFaceLivenessVerifierViewController {
    func setupVerifier() {
        verifier.reset()
        verifier.showDebugInfo = false
        verifier.update(settings: FaceLivenessVerifierSettings())
    }
}

// MARK: - Camera session setup

extension PureFaceLivenessVerifierViewController {
    func setupCameraSession() -> Bool {
        var deviceTypes = [AVCaptureDevice.DeviceType.builtInWideAngleCamera]
        if #available(iOS 13.0, *) {
            deviceTypes.append(.builtInDualWideCamera)
            deviceTypes.append(.builtInTripleCamera)
        }
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                                      mediaType: .video,
                                                                      position: .front)
        guard let device = deviceDescoverySession.devices.last else { return false }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        self.previewLayer = previewLayer

        captureSession.beginConfiguration()
        captureSession.sessionPreset = .high
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }

        guard let input = try? AVCaptureDeviceInput(device: device) else { return false }
        captureSession.addInput(input)

        let cameraVideoOutput = AVCaptureVideoDataOutput()
        cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA] as [String: Any]
        cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)
        captureSession.addOutput(cameraVideoOutput)

        captureSession.commitConfiguration()

        return true
    }

    func setOrientation(orientation: UIDeviceOrientation) {
        if #available(iOS 13.0, *) {
            for connection in captureSession.connections {
                switch UIDevice.current.orientation {
                case .portrait:
                    previewLayer?.connection?.videoOrientation = .portrait
                    connection.videoOrientation = .portrait
                case .landscapeRight:
                    previewLayer?.connection?.videoOrientation = .portrait
                    connection.videoOrientation = .landscapeLeft
                case .landscapeLeft:
                    previewLayer?.connection?.videoOrientation = .portrait
                    connection.videoOrientation = .landscapeRight
                case .portraitUpsideDown:
                    previewLayer?.connection?.videoOrientation = .portrait
                    connection.videoOrientation = .portraitUpsideDown
                default:
                    break
                }
            }
        }
    }
}
