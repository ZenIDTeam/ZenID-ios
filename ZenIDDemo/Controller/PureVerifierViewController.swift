//
//  PureVerifierViewController.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 18.10.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import AVFoundation
import Foundation
import RecogLib_iOS
import UIKit

enum PureVerifierError: Error {
    case notInitialized
}

typealias TakePictureCallback = (Result<Data, Error>) -> Void

public struct Configuration {
    public static let `default` = Configuration(
        showVisualisation: true,
        showHelperVisualisation: true,
        showDebugVisualisation: false,
        dataType: .picture,
        role: nil,
        country: nil,
        page: nil,
        code: nil,
        documents: nil,
        settings: nil
    )

    public let showVisualisation: Bool
    public let showHelperVisualisation: Bool
    public let showDebugVisualisation: Bool
    public let dataType: DataType
    public let role: RecogLib_iOS.DocumentRole?
    public let country: RecogLib_iOS.Country?
    public let page: RecogLib_iOS.PageCode?
    public let code: RecogLib_iOS.DocumentCode?
    public let documents: [Document]?
    public let settings: DocumentVerifierSettings?
}

final class PureVerifierViewController: UIViewController {
    // MARK: - Public properties

    public var takePictureCompletion: TakePictureCallback?

    // MARK: - Private properties

    private let verifier: DocumentVerifier
    private(set) var previewLayer: AVCaptureVideoPreviewLayer?
    private let cameraCaptureQueue = DispatchQueue(label: "cz.trask.zenid.cameraCaptureQueue")
    private var captureDevice: AVCaptureDevice?
    private let captureSession = AVCaptureSession()
    private var cameraPhotoOutput: AVCapturePhotoOutput!
    private var cameraVideoOutput: AVCaptureVideoDataOutput!

    private let topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    init() {
        verifier = .init(
            role: RecogLib_iOS.DocumentRole.Idc,
            country: RecogLib_iOS.Country.Cz,
            page: RecogLib_iOS.PageCode.Front,
            code: nil,
            language: .Czech
        )
        verifier.showDebugInfo = true
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        verifier.endHologramVerification()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loadModels(url: .modelsDocuments)
        configure(with: .default)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stop()
    }

    // MARK: - Public functions

    func configure(with configuration: Configuration) {
        let captureDevicePosition: AVCaptureDevice.Position = .back
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: captureDevicePosition
        )
        captureDevice = deviceDiscoverySession.devices.first

        guard let device = captureDevice, setupCameraSession(device) else { return }
        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        }

        setupVerifier(with: configuration)
    }

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

    func takePicture(completion: @escaping TakePictureCallback) {
        guard captureDevice != nil else {
            completion(.failure(PureVerifierError.notInitialized))
            return
        }
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            completion(.failure(PureVerifierError.notInitialized))
            return
        }
        takePictureCompletion = completion
        cameraPhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }

    // MARK: - Private functions

    private func loadModels(url: URL) {
        guard let models = DocumentVerifierModels(url: url) else {
            return
        }
        verifier.loadModels(models)
    }

    private func verifyImage(buffer: CMSampleBuffer) {
        let result = verifier.verify(buffer: buffer)
    }

    private func getCurrentResolution() -> CGSize {
        guard let formatDescription = captureDevice?.activeFormat.formatDescription else {
            return .zero
        }
        let dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription)
        return CGSize(width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension PureVerifierViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        verifyImage(buffer: sampleBuffer)
    }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension PureVerifierViewController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            takePictureCompletion?(.failure(error))
        } else if let data = photo.fileDataRepresentation() {
            takePictureCompletion?(.success(data))
        }
        takePictureCompletion = nil
    }
}

extension PureVerifierViewController {
    func setupUI(with configuration: Configuration) {
        topLabel.text = configuration.page == .Back ? LocalizedString("msg-scan-back", comment: "") : LocalizedString("msg-scan-front", comment: "")
    }
}


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
//        if let code = previousResult?.code, config.page == .Back {
//            verifier.code = code
//        }
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

extension PureVerifierViewController {
    func setupCameraSession(_ device: AVCaptureDevice) -> Bool {
        guard let input = try? AVCaptureDeviceInput(device: device) else { return false }

        previewLayer?.videoGravity = .resizeAspectFill
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
        cameraVideoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA] as [String: Any]
        cameraVideoOutput.setSampleBufferDelegate(self, queue: cameraCaptureQueue)

        captureSession.addInput(input)
        captureSession.addOutput(cameraPhotoOutput)
        captureSession.addOutput(cameraVideoOutput)
        captureSession.commitConfiguration()

        return true
    }
}
