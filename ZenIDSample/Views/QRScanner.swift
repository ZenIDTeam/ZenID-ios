//
//  QRScanner.swift
//  ZenID Sample
//
//  Created by Vladimir Belohradsky on 02.12.2024.
//  Copyright © 2024 ZenID s.r.o. All rights reserved.
//

import SwiftUI
@preconcurrency import AVFoundation
import ZenID


/// Scan QR code.
struct QRScanner: UIViewRepresentable {
    
    typealias OnQRCodeDetected = (_ code: String) -> Bool
    
    private let cameraView = UIView()
    
    /// Callback when an QR code is detected.
    let onQrCodeDetected: OnQRCodeDetected
    
    func makeUIView(context: Context) -> some UIView {
        return cameraView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let layer = context.coordinator.videoPreviewLayer {
            layer.frame = uiView.bounds
        }
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(onSetupLayer: { previewLayer in
            cameraView.layer.insertSublayer(previewLayer, at: 0)
        }, onQrCodeDetected: onQrCodeDetected)
        return coordinator
    }
    
}

extension QRScanner {
    
    @MainActor class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        
        typealias OnSetupLayer = (_ layer: AVCaptureVideoPreviewLayer) -> Void
        
        private var captureSession: AVCaptureSession?
        
        private(set) var videoPreviewLayer: AVCaptureVideoPreviewLayer?
        
        private var lastCapturedData: String = ""
        
        private var onSetupLayer: OnSetupLayer
        
        private var onQrCodeDetected: OnQRCodeDetected
        
        init(
            onSetupLayer: @escaping OnSetupLayer,
            onQrCodeDetected: @escaping OnQRCodeDetected
        ) {
            self.onSetupLayer = onSetupLayer
            self.onQrCodeDetected = onQrCodeDetected
            super.init()
            self.startCamera()
        }
        
        deinit {
            if captureSession?.isRunning == true {
                captureSession?.stopRunning()
            }
        }
        
        /// Setup for QR code scanning.
        func startCamera() {
            captureSession = AVCaptureSession()
            guard let captureSession else { return }
            
            // Get the back-facing camera for capturing videos
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTripleCamera,
                                                                                        .builtInDualWideCamera,
                                                                                        .builtInWideAngleCamera],
                                                                          mediaType: .video,
                                                                          position: .back)
            
            guard let captureDevice = deviceDiscoverySession.devices.first else {
                OSLogger.app.error("Failed to get the camera device")
                return
            }
            
            do {
                // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                // Set the input device on the capture session.
                captureSession.addInput(input)
                
            } catch {
                // If any error occurs, simply print it out and don't continue any more.
                OSLogger.app.error("Error attaching input \(error.localizedDescription)")
                return
            }
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            if let videoPreviewLayer {
                onSetupLayer(videoPreviewLayer)
            }
            
            do {
                try captureDevice.lockForConfiguration()
                captureDevice.videoZoomFactor =
                CGFloat(captureDevice.virtualDeviceSwitchOverVideoZoomFactors.first?.floatValue ?? 2)
                captureDevice.unlockForConfiguration()
            } catch {
                OSLogger.app.error("Error changing camera zoom factor: \(error.localizedDescription)")
            }
            
            // Start video capture.
            Task.detached(priority: .userInitiated) {
                captureSession.startRunning()
            }
        }
        
        private func stopCamera() {
            // Stop video capture.
            
            if captureSession?.isRunning == true {
                captureSession?.stopRunning()
            }
            captureSession = nil
            lastCapturedData = ""
        }
        
        // MARK: - AVCaptureMetadataOutputObjectsDelegate
        
        nonisolated func metadataOutput(
            _ output: AVCaptureMetadataOutput,
            didOutput metadataObjects: [AVMetadataObject],
            from connection: AVCaptureConnection
        ) {
            guard let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = metadataObj.stringValue else { return }
            
            Task { @MainActor in
                if onQrCodeDetected(code) {
                    stopCamera()
                }
            }
        }
        
    }
}
