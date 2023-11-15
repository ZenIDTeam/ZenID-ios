//
//  Example of an implementation from scratch when you need to implement a custom UI
//
//  Created by Lukáš Gergel on 18.10.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import AVFoundation
import Foundation
import RecogLib_iOS
import UIKit

public struct Configuration {
    public static let `default` = Configuration(
        showDebugVisualisation: false,
        dataType: .picture,
        role: .Idc,
        country: .Cz,
        page: .F,
        code: nil,
        documents: nil,
        settings: nil
    )

    public let showDebugVisualisation: Bool
    public let dataType: DataType
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let page: RecogLib_iOS.PageCodes?
    public let code: RecogLib_iOS.DocumentCodes?
    public let documents: [Document]?
    public let settings: DocumentVerifierSettings?
}

final class PureVerifierViewController: UIViewController {
    // MARK: - Private properties

    private let verifier: DocumentVerifier

    private(set) var previewLayer: AVCaptureVideoPreviewLayer?
    private(set) var drawingLayer = DrawingLayer()

    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.zenid.cameraCaptureQueue")
    private let captureSession = AVCaptureSession()
    private var cameraVideoOutput: AVCaptureVideoDataOutput!

    // MARK: - Init

    init() {
        verifier = .init(
            role: RecogLib_iOS.DocumentRole.Idc,
            country: RecogLib_iOS.Country.Cz,
            page: RecogLib_iOS.PageCodes.F,
            code: nil,
            language: .Czech
        )
        verifier.showDebugInfo = true

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

        loadModels(url: .modelsDocuments)

        guard setupCameraSession() else { return }
        setupVerifier(with: .default)
        setupUI(with: .default)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setOrientation(orientation: UIDevice.current.orientation)
        start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        verifier.endHologramVerification()
        stop()
    }

    // MARK: - Public functions

    func start() {
        if captureSession.isRunning {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

    func stop() {
        if !captureSession.isRunning {
            return
        }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
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
        guard let models = DocumentVerifierModels(url: url) else {
            return
        }
        verifier.loadModels(models)
    }

    private func verifyImage(buffer: CMSampleBuffer) {
        // test code to verify that the image orientation is always correct
//        if #available(iOS 13.0, *) {
//            if let ib = buffer.imageBuffer {
//                let debugImage = UIImage(pixelBuffer: ib)
//            }
//        }
        let result = verifier.verify(buffer: buffer)
        // process the verifier result here
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

extension PureVerifierViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        verifyImage(buffer: sampleBuffer)
        drawRenderables(buffer: sampleBuffer)
    }
}

// MARK: - UI setup

extension PureVerifierViewController {
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

extension PureVerifierViewController {
    func setupVerifier(with configuration: Configuration) {
        verifier.reset()
        verifier.endHologramVerification()
        resetDocumentVerifier()

        if let settings = configuration.settings {
            verifier.update(settings: settings)
        }

        // This will setup document verifier
        if let role = configuration.role {
            verifier.documentRole = role
        }
        if let page = configuration.page {
            verifier.page = page
        }
        if let country = configuration.country {
            verifier.country = country
        }
        if let documents = configuration.documents {
            verifier.documentsInput = .init(documents: documents)
        }

        if configuration.dataType == .video {
            verifier.beginHologramVerification()
        }

        verifier.showDebugInfo = configuration.showDebugVisualisation
    }

    private func resetDocumentVerifier() {
        verifier.documentsInput = nil
        verifier.documentRole = nil
        verifier.page = nil
        verifier.country = nil
        verifier.code = nil
    }
}

// MARK: - Camera session setup

extension PureVerifierViewController {
    func setupCameraSession() -> Bool {
        guard let device = AVCaptureDevice.default(for: .video) else { return false }
        var deviceTypes = [AVCaptureDevice.DeviceType.builtInWideAngleCamera]
        if #available(iOS 13.0, *) {
            deviceTypes.append(.builtInDualWideCamera)
            deviceTypes.append(.builtInTripleCamera)
        }
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                                      mediaType: .video,
                                                                      position: .back)
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
        
        // Zoom factor is necessary only for multifocal systems.
        guard device.deviceType != .builtInWideAngleCamera else { return true }
        if #available(iOS 13.0, *) {
            do {
                try device.lockForConfiguration()
                device.videoZoomFactor =
                CGFloat(device.virtualDeviceSwitchOverVideoZoomFactors.first?.floatValue ?? 1)
                device.unlockForConfiguration()
            } catch {
                // Let it gracefully be.
            }
        }

        return true
    }

    func setOrientation(orientation: UIDeviceOrientation) {
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
