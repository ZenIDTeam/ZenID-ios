//
//  ViewController.swift
//  ZenIDWebviewDemo
//
//  Created by Lukáš Gergel on 02.11.2022.
//

import AVFoundation
import Foundation
import RecogLib_iOS
import UIKit

class ViewController: UIViewController {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var webViewOverlay: WebViewOverlay?
    let camera = Camera()
#if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
    var imagePicker = UIImagePickerController()
#endif

    init() {
        super.init(nibName: nil, bundle: nil)
    }


    deinit {
        print("deinit")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var delayCounter: Int = 0
    // This is for adding delay so user will get sufficient time for align QR within frame
    private let delayCount: Int = 15

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        
        let image = UIImage(named: "nati")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)

        imageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)

        try? camera.configure(with: CameraConfiguration(type: .back, variant: .qrCode))
        camera.takeQrCodeCompletion = { [weak self] qrCode in
            self?.processQr(qrCode)
        }
        previewLayer = camera.previewLayer
        if let previewLayer {
            view.layer.addSublayer(previewLayer)
        }

        addWebViewOverlay()
        webViewOverlay?.loadOffline()

#if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
    addGalleryPickerButton(view)
#endif
        Task {
            let hasCameraPermission = await requestCameraPermission()
            if hasCameraPermission {
                camera.start()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let previewLayer = previewLayer {
            previewLayer.frame = view.bounds
        }
    }
    
    
    private func requestCameraPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                continuation.resume(returning: granted)
            })
        }
    }

    func addWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        let webView = WebViewOverlay()
        view.addSubview(webView)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
//        view.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
//        view.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
//        view.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        webViewOverlay = webView
    }

    func removeWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        webViewOverlay = nil
    }

    private func processQr(_ qrCode: AVMetadataMachineReadableCodeObject) {
        if view.bounds.contains(qrCode.bounds) {
            delayCounter = delayCounter + 1
            if delayCounter > delayCount {
                if let unwrapedStringValue = qrCode.stringValue {
                    //delegate?.qrSuccess(self, scanDidComplete: unwrapedStringValue, completion: successCompletion)
                } else {
                    //delegate?.qrFail(self, error: "Empty string found")
                }
                //dismiss(animated: true, completion: nil)
            }
        }
    }

#if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
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
        pickerButton.setTitle("debug: login-qr-gallery", for: .normal)
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
}

#if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
    extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            dismiss(animated: true)

            guard let image = info[.originalImage] as? UIImage else { return }
            if let text = getTextFromQR(from: image) {
                //delegate?.qrSuccess(self, scanDidComplete: text, completion: successCompletion)
                camera.stop()
                //dismiss(animated: true, completion: nil)
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
