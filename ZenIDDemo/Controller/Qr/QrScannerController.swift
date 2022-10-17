//
//  QrScannerController.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 11/05/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import UIKit
import AVFoundation
import RecogLib_iOS

/// QrScannerController presents view with AVCaptureSession and previewLayer to scan QR codes
public class QrScannerController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationBarDelegate {
    
    private var squareView: QrSquareView? = nil
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
    lazy var frontCaptureInput: AVCaptureInput?  = {
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
        addCancelButton(view)
        startCaptureSession()
    }
    
    //MARK: - Setup scanner view

    private func addViedoPreviewLayer(_ view: UIView) {
        videoPreviewLayer.frame = CGRect(
            x:view.bounds.origin.x,
            y: view.bounds.origin.y,
            width: view.bounds.size.width,
            height: view.bounds.size.height - bottomSpace)
        view.layer.insertSublayer(videoPreviewLayer, at: 0)
    }

    private func createCornerFrame() {
        let rect = CGRect.init(
            origin: CGPoint.init(
                x: self.view.frame.midX - squareWidth / 2,
                y: self.view.frame.midY - (squareWidth + bottomSpace) / 2),
            size: CGSize.init(width: squareWidth, height: squareHeight))
        self.squareView = QrSquareView(frame: rect)
        if let squareView = squareView {
            self.view.backgroundColor = UIColor(white: 0.0, alpha: 1.0)
            squareView.autoresizingMask = UIView.AutoresizingMask(rawValue: UInt(0.0))
            self.view.addSubview(squareView)
            
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
             x: view.frame.width/2 - btnWidthWhenCancelImageNil/2,
             y: view.frame.height - 60,
             width: btnWidthWhenCancelImageNil,
             height: height)
        cancelButton.setTitle("login-qr-cancel".localized, for: .normal)
        cancelButton.contentMode = .scaleAspectFit
        cancelButton.addTarget(self, action: #selector(dismissVC), for:.touchUpInside)
        view.addSubview(cancelButton)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
        delegate?.qrCancel(self)
    }
    
    //MARK: - Capturing session

    private func setupCaptureSession() {
        if captureSession.isRunning { return }
        
        // input
        if let defaultDeviceInput = defaultCaptureInput {
            if !captureSession.canAddInput(defaultDeviceInput) {
                delegate?.qrFail(self, error: "Failed to add Input")
                self.dismiss(animated: true, completion: nil)
                return
            }
            captureSession.addInput(defaultDeviceInput)
        }
        
        // output
        if !captureSession.canAddOutput(dataOutput) {
            delegate?.qrFail(self, error: "Failed to add Output")
            self.dismiss(animated: true, completion: nil)
            return
        }
        captureSession.addOutput(dataOutput)
        dataOutput.metadataObjectTypes = dataOutput.availableMetadataObjectTypes
        dataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    }
    
    private func startCaptureSession() {
        if captureSession.isRunning { return }
        DispatchQueue.global().async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
}

//MARK: - Make sure orientation is portrait
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

//MARK: - AVCapture metadata output
extension QrScannerController: AVCaptureMetadataOutputObjectsDelegate {
    // This method get called when Scanning gets complete
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for data in metadataObjects {
            let transformed = videoPreviewLayer.transformedMetadataObject(for: data) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                if view.bounds.contains(unwraped.bounds) {
                    delayCounter = delayCounter + 1
                    if delayCounter > delayCount {
                        if let unwrapedStringValue = unwraped.stringValue {
                            delegate?.qrSuccess(self, scanDidComplete: unwrapedStringValue, completion: self.successCompletion)
                        } else {
                            delegate?.qrFail(self, error: "Empty string found")
                        }
                        DispatchQueue.global().async { [weak self] in
                            self?.captureSession.stopRunning()
                        }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
