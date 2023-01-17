import AVFoundation
import Common
import RecogLib_iOS
import UIKit

class SimulatorCamera {
    func start() {}
    func stop() {}
}

enum QRViewEvent {
    case qrAuthorized(code: String)
    case qrFailed
}

final class QRCodeViewController: GenericViewController {
    private let configuration: ScreenConfiguration
    private let onEvent: EventCallback // (QRViewEvent) -> Void

    #if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
        private let imagePicker = UIImagePickerController()
        private let camera = SimulatorCamera()
        private var previewLayer: UIImageView?
    #else
        private let camera = Camera()
        private var previewLayer: AVCaptureVideoPreviewLayer?
    #endif
    private var delayCounter: Int = 0
    // This is for adding delay so user will get sufficient time for align QR within frame
    private let delayCount: Int = 15

    public init(onEvent: @escaping EventCallback) {
        configuration = ScreenConfiguration(feature: .scan)
        self.onEvent = onEvent
        super.init()
        // super.init(onEvent: onEvent)
        loadConfiguration(configuration: configuration)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        #if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
//            addGalleryPickerButton(view)
//            let imgPath = Bundle.main.path(forResource: "sample-bg", ofType: ".jpg")!
//            let previewLayer = UIImageView(image: UIImage(named: imgPath))
//            self.previewLayer = previewLayer
//            view.layer.insertSublayer(previewLayer.layer, at: 0)
//            loadWebView()
//        #else
//            Task {
//                let hasCameraPermission = await requestCameraPermission()
//                if hasCameraPermission {
//                    try? camera.configure(with: CameraConfiguration(type: .back, variant: .qrCode))
//                    camera.takeQrCodeCompletion = { [weak self] qrCode in
//                        self?.processQr(qrCode)
//                    }
//                    previewLayer = camera.previewLayer
//                    if let previewLayer {
//                        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//                        view.layer.insertSublayer(previewLayer, at: 0)
//                        // view.layer.addSublayer(previewLayer)
//                        // addWebViewOverlay()
//                        loadWebView()
//                    }
//                    view.setNeedsLayout()
//                    camera.start()
//                }
//            }
//        #endif
//    }

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

    override func didReceiveEvent(_ event: WebEvent) {
        // TODO: handle and process generic events
        // onEvent(AppEvent(feature: event.previousEvent.feature, data: event.previousEvent.base64))
    }

    private func loadWebView() {
        do {
            let event = try configuration.toJson()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.sendEvent(event)
            }
        } catch {
            print(error)
        }
    }

    private func processQr(_ qrCode: AVMetadataMachineReadableCodeObject) {
        if view.bounds.contains(qrCode.bounds) {
            delayCounter = delayCounter + 1
            if delayCounter > delayCount {
                if let unwrapedStringValue = qrCode.stringValue {
                    qrSuccess(result: unwrapedStringValue, completion: { [weak self] in
                        self?.onEvent(WebEvent(previousEvent: .init(feature: .scan), nextEvent: nil))
                        // self?.onEvent(.qrAuthorized(code: unwrapedStringValue))
                    })
                    // delegate?.qrSuccess(self, scanDidComplete: unwrapedStringValue, completion: successCompletion)
                } else {
                    onEvent(WebEvent(previousEvent: .init(feature: .scan), nextEvent: nil))
                    // onEvent(.qrFailed)
                    // delegate?.qrFail(self, error: "Empty string found")
                }
                // dismiss(animated: true, completion: nil)
            }
        }
    }

    func qrSuccess(result: String, completion: (() -> Void)?) {
        if let qr = CredentialsQrCode(value: result), qr.isValid {
            Credentials.shared.update(apiURL: qr.apiURL!, apiKey: qr.apiKey!)
            // Haptics.shared.success()
            if let completion = completion {
                AuthManager.zenidAuthorize(completion: { isAuthorized in
                    if !isAuthorized {
                        Credentials.shared.clear()
                    } else {
                        completion()
                    }
                })
            }
            ApplicationLogger.shared.Verbose("Credentials updated, apiURL: \(Credentials.shared.apiURL?.absoluteString ?? ""), apiKey: \(Credentials.shared.apiKey ?? "")")
        }
    }

    override func didTakePictureManually(image: UIImage) {
        if let text = getTextFromQR(from: image) {
            qrSuccess(result: text, completion: { [weak self] in
                self?.onEvent(.init(previousEvent: .init(feature: .scan), nextEvent: nil))
                // self?.onEvent(.qrAuthorized(code: text))
            })
            camera.stop()
            // dismiss(animated: true, completion: nil)
        }
    }

//    #if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
//        private func addGalleryPickerButton(_ view: UIView) {
//            let height: CGFloat = 44.0
//            let btnWidth: CGFloat = 320.0
//
//            // Pick image from gallery button
//            let pickerButton = UIButton()
//            pickerButton.frame = CGRect(
//                x: view.frame.width / 2 - btnWidth / 2,
//                y: view.frame.height - 120,
//                width: btnWidth,
//                height: height)
//            pickerButton.setTitle("debug: login-qr-gallery", for: .normal)
//            pickerButton.contentMode = .scaleAspectFit
//            pickerButton.addTarget(self, action: #selector(openGalleryVC), for: .touchUpInside)
//            view.addSubview(pickerButton)
//        }
//
//        @objc func openGalleryVC() {
//            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
//                print("Button capture")
//
//                imagePicker.delegate = self
//                imagePicker.sourceType = .savedPhotosAlbum
//                imagePicker.allowsEditing = false
//
//                present(imagePicker, animated: true, completion: nil)
//            }
//        }
//    #endif
}

// #if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
//    extension QRCodeViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
//        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            dismiss(animated: true)
//
//            guard let image = info[.originalImage] as? UIImage else { return }
//            if let text = getTextFromQR(from: image) {
//                qrSuccess(result: text, completion: { [weak self] in
//                    self?.onEvent(.init(previousEvent: .init(feature: .scan), nextEvent: nil))
//                    // self?.onEvent(.qrAuthorized(code: text))
//                })
//                camera.stop()
//                // dismiss(animated: true, completion: nil)
//            }
//        }
//
//        func getTextFromQR(from image: UIImage) -> String? {
//            var qrString = ""
//            guard let detector = CIDetector(ofType: CIDetectorTypeQRCode,
//                                            context: nil,
//                                            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
//                let ciImage = CIImage(image: image),
//                let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else { return nil }
//
//            for feature in features {
//                guard let indeedMessageString = feature.messageString else { continue }
//                qrString += indeedMessageString
//            }
//            guard qrString.count > 0 else { return nil }
//            return qrString
//        }
//    }
// #endif
