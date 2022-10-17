//
//  QrScannerController.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 11/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import AVFoundation
import RecogLib_iOS
import UIKit

/// QrScannerController presents view with AVCaptureSession and previewLayer to scan QR codes
public class QrScannerController: UIViewController, UINavigationBarDelegate {
    private var squareView: QrSquareView?
    public var successCompletion: (() -> Void)?
    public weak var delegate: QrScannerControllerDelegate?

    // Constants
    private let squareWidth: CGFloat = 250.0
    private let squareHeight: CGFloat = 250.0

    // Default Properties
    private let bottomSpace: CGFloat = 80.0
    private let spaceFactor: CGFloat = 16.0
    private var delayCounter: Int = 0

    // This is for adding delay so user will get sufficient time for align QR within frame
    private let delayCount: Int = 15

    // Initialise CaptureDevice
    lazy var defaultDevice: AVCaptureDevice? = {
        if let device = AVCaptureDevice.default(for: .video) {
            return device
        }
        return nil
    }()

    // Initialise front CaptureDevice
    lazy var frontDevice: AVCaptureDevice? = {
        if #available(iOS 10, *) {
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                return device
            }
        } else {
            for device in AVCaptureDevice.devices(for: .video) {
                if device.position == .front { return device }
            }
        }
        return nil
    }()

    // Initialise AVCaptureInput with defaultDevice
    lazy var defaultCaptureInput: AVCaptureInput? = {
        if let captureDevice = defaultDevice {
            do {
                return try AVCaptureDeviceInput(device: captureDevice)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }()

    // Initialise AVCaptureInput with frontDevice
    lazy var frontCaptureInput: AVCaptureInput? = {
        if let captureDevice = frontDevice {
            do {
                return try AVCaptureDeviceInput(device: captureDevice)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }()

    lazy var dataOutput = AVCaptureMetadataOutput()

    // Initialise capture session
    lazy var captureSession = AVCaptureSession()

    // Initialise videoPreviewLayer with capture session
    lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.cornerRadius = 10.0
        return layer
    }()

    #if targetEnvironment(simulator)
        var imagePicker = UIImagePickerController()
    #endif

    deinit {
        ApplicationLogger.shared.Info("QrScanner deallocating..")
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // set portraint mode
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")

        // reset delay counter
        delayCounter = 0

        setupCaptureSession()
        addViedoPreviewLayer(view)
        createCornerFrame()
        #if targetEnvironment(simulator)
            addGalleryPickerButton(view)
        #endif
        addCancelButton(view)
        startCaptureSession()
    }

    // MARK: - Setup scanner view

    private func addViedoPreviewLayer(_ view: UIView) {
        videoPreviewLayer.frame = CGRect(
            x: view.bounds.origin.x,
            y: view.bounds.origin.y,
            width: view.bounds.size.width,
            height: view.bounds.size.height - bottomSpace)
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
    }

    private func createCornerFrame() {
        let rect = CGRect(
            origin: CGPoint(
                x: view.frame.midX - squareWidth / 2,
                y: view.frame.midY - (squareWidth + bottomSpace) / 2),
            size: CGSize(width: squareWidth, height: squareHeight))
        squareView = QrSquareView(frame: rect)
        if let squareView = squareView {
            view.backgroundColor = UIColor(white: 0.0, alpha: 1.0)
            squareView.autoresizingMask = UIView.AutoresizingMask(rawValue: UInt(0.0))
            view.addSubview(squareView)

            addMaskLayerToVideoPreviewLayerAndAddText(rect: rect)
        }
    }

    private func addMaskLayerToVideoPreviewLayerAndAddText(rect: CGRect) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.fillColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        let path = UIBezierPath(rect: rect)
        path.append(UIBezierPath(rect: view.bounds))
        maskLayer.path = path.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        view.layer.insertSublayer(maskLayer, above: videoPreviewLayer)

        let noteText = CATextLayer()
        noteText.fontSize = 18.0
        noteText.string = "login-qr-note".localized
        noteText.alignmentMode = CATextLayerAlignmentMode.center
        noteText.contentsScale = UIScreen.main.scale
        noteText.frame = CGRect(
            x: spaceFactor,
            y: rect.origin.y + rect.size.height + 30,
            width: view.frame.size.width - (2.0 * spaceFactor),
            height: 22)
        noteText.foregroundColor = UIColor.white.cgColor
        view.layer.insertSublayer(noteText, above: maskLayer)
    }

    private func addCancelButton(_ view: UIView) {
        let height: CGFloat = 44.0
        let btnWidthWhenCancelImageNil: CGFloat = 60.0

        // Cancel button
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(
            x: view.frame.width / 2 - btnWidthWhenCancelImageNil / 2,
            y: view.frame.height - 60,
            width: btnWidthWhenCancelImageNil,
            height: height)
        cancelButton.setTitle("login-qr-cancel".localized, for: .normal)
        cancelButton.contentMode = .scaleAspectFit
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        view.addSubview(cancelButton)
    }

    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
        delegate?.qrCancel(self)
    }

    #if targetEnvironment(simulator)
        private func addGalleryPickerButton(_ view: UIView) {
            let height: CGFloat = 44.0
            let btnWidth: CGFloat = 320.0

            // Pick image from gallery button
            let pickerButton = UIButton()
            pickerButton.frame = CGRect(
                x: view.frame.width / 2 - btnWidth / 2,
                y: view.frame.height - 120,
                width: btnWidth,
                height: height)
            pickerButton.setTitle("login-qr-gallery".localized, for: .normal)
            pickerButton.contentMode = .scaleAspectFit
            pickerButton.addTarget(self, action: #selector(openGalleryVC), for: .touchUpInside)
            view.addSubview(pickerButton)
        }

        @objc func openGalleryVC() {
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                print("Button capture")

                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false

                present(imagePicker, animated: true, completion: nil)
            }
        }
    #endif

    // MARK: - Capturing session

    private func setupCaptureSession() {
        if captureSession.isRunning { return }

        // input
        if let defaultDeviceInput = defaultCaptureInput {
            if !captureSession.canAddInput(defaultDeviceInput) {
                delegate?.qrFail(self, error: "Failed to add Input")
                dismiss(animated: true, completion: nil)
                return
            }
            captureSession.addInput(defaultDeviceInput)
        }

        // output
        if !captureSession.canAddOutput(dataOutput) {
            delegate?.qrFail(self, error: "Failed to add Output")
            dismiss(animated: true, completion: nil)
            return
        }
        captureSession.addOutput(dataOutput)
        dataOutput.metadataObjectTypes = dataOutput.availableMetadataObjectTypes
        dataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }

    private func startCaptureSession() {
        if captureSession.isRunning { return }
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
}

// MARK: - Make sure orientation is portrait

extension QrScannerController {
    override public var shouldAutorotate: Bool {
        return false
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
}

// MARK: - AVCapture metadata output

extension QrScannerController: AVCaptureMetadataOutputObjectsDelegate {
    func debug() {
        // AVMetadataMachineReadableCodeObject
    }

    // This method get called when Scanning gets complete
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for data in metadataObjects {
            let transformed = videoPreviewLayer.transformedMetadataObject(for: data) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                if view.bounds.contains(unwraped.bounds) {
                    delayCounter = delayCounter + 1
                    if delayCounter > delayCount {
                        if let unwrapedStringValue = unwraped.stringValue {
                            delegate?.qrSuccess(self, scanDidComplete: unwrapedStringValue, completion: successCompletion)
                        } else {
                            delegate?.qrFail(self, error: "Empty string found")
                        }
                        DispatchQueue.global(qos: .default).async { [weak self] in
                            self?.captureSession.stopRunning()
                        }
                        dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

#if targetEnvironment(simulator)
    extension QrScannerController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            dismiss(animated: true)

            guard let image = info[.originalImage] as? UIImage else { return }
            if let text = getTextFromQR(from: image) {
                delegate?.qrSuccess(self, scanDidComplete: text, completion: successCompletion)
                DispatchQueue.global(qos: .default).async { [weak self] in
                    self?.captureSession.stopRunning()
                }
                dismiss(animated: true, completion: nil)
            }
        }

        func getTextFromQR(from image: UIImage) -> String? {
            var qrString = ""
            guard let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                            context: nil,
                                            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
                let ciImage = CIImage(image: image),
                let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else { return nil }

            for feature in features {
                guard let indeedMessageString = feature.messageString else { continue }
                qrString += indeedMessageString
            }
            guard qrString.count > 0 else { return nil }
            return qrString
        }
    }
#endif
