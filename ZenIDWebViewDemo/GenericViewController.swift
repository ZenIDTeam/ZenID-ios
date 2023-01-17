import AVFoundation
import RecogLib_iOS
import UIKit

public protocol ResultState {
    var isOk: Bool { get }
    var description: String { get }
}

typealias EventCallback = (WebEvent) -> Void

open class GenericViewController: WebViewController {
    private var onEvent: EventCallback?
    private var targetFrame: CGRect = .zero

    #if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
        private let imagePicker = UIImagePickerController()
        private let camera = SimulatorCamera()
        private var previewLayer: UIImageView?
    #else
        private let camera = Camera()
        private var previewLayer: AVCaptureVideoPreviewLayer?
    #endif

    // MARK: - Lifecycle

    override init() {
        super.init()

        NotificationCenter.default.addObserver(
            self, selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification, object: nil
        )
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        // setTorch(on: false)
        // videoWriter?.stop()
    }

    @objc
    private func orientationChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.updateOrientation()
        }
    }

    @objc
    private func updateOrientation() {
        print("🪟 updateOrientation()")
//        targetFrame = view.overlay?.bounds ?? .zero
//        camera.setOrientation(orientation: UIDevice.current.orientation)
//        view.drawLayer?.setRenderables([])
//        view.rotateOverlay(targetFrame: getOverlayTargetFrame())
//        if let videoWriter = videoWriter, videoWriter.isRecording {
//            videoWriter.stopAndCancel()
//            DispatchQueue.main.async { [weak self] in
//                self?.startVideoWriter()
//            }
//        }
    }

    func setEventCallback(onEvent: @escaping EventCallback) {
        self.onEvent = onEvent
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        #if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
            addGalleryPickerButton(view)
            let imgPath = Bundle.main.path(forResource: "sample-bg", ofType: ".jpg")!
            let previewLayer = UIImageView(image: UIImage(named: imgPath))
            self.previewLayer = previewLayer
            view.layer.insertSublayer(previewLayer.layer, at: 0)
//            loadWebView()
        #else
            Task {
                let hasCameraPermission = await requestCameraPermission()
                if hasCameraPermission {
                    try? camera.configure(with: CameraConfiguration(type: .back, variant: .qrCode))
                    camera.takeQrCodeCompletion = { [weak self] qrCode in
                        self?.processQr(qrCode)
                    }
                    previewLayer = camera.previewLayer
                    if let previewLayer {
                        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                        view.layer.insertSublayer(previewLayer, at: 0)
                        // view.layer.addSublayer(previewLayer)
                        // addWebViewOverlay()
                        loadWebView()
                    }
                    view.setNeedsLayout()
                    camera.start()
                }
            }
        #endif
    }

    override func didReceiveEvent(_ event: WebEvent) {
        onEvent?(event)
    }

    func loadConfiguration(configuration: JsonConvertible) {
        do {
            let event = try configuration.toJson()
            sendEvent(event)
        } catch {
            print(error)
        }
    }
    
    public func didTakePictureManually(image: UIImage) {
        
    }
    
    func verify(pixelBuffer: CVPixelBuffer) -> ResultState? {
        nil
    }
}

extension GenericViewController: CameraDelegate {
    public func cameraDelegate(camera: Camera, onOutput sampleBuffer: CMSampleBuffer) {
//        guard isRunning else { return }
//        guard targetFrame.width > 0 else { return }

        // crop pixel data if necessary
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let croppedBuffer = camera.getCroppedPixelBuffer(pixelBuffer: pixelBuffer, targetFrame: targetFrame) else { return }
        let imageWidth = CVPixelBufferGetWidth(croppedBuffer)
        let imageHeight = CVPixelBufferGetHeight(croppedBuffer)
        let imageRect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)

//        if let videoWriter = videoWriter, baseConfig.dataType == .video, videoWriter.isRecording {
//            videoWriter.captureOutput(sampleBuffer: sampleBuffer)
//        }
        guard let result = verify(pixelBuffer: croppedBuffer) else {
            return
        }
//        callUpdateDelegate(with: result)
//        DispatchQueue.main.async { [unowned self] in
//            self.updateView(with: result, buffer: croppedBuffer)
//        }
//        guard let canvasSize = camera.previewLayer?.frame.size, let commands = getRenderCommands(size: canvasSize) else {
//            return
//        }
//        DispatchQueue.main.async {
//            self.renderCommands(commands: commands, imageRect: imageRect, pixelBuffer: pixelBuffer)
//        }
    }
}

#if targetEnvironment(simulator) || targetEnvironment(macCatalyst)
    extension GenericViewController {
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
    }

    extension GenericViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            dismiss(animated: true)

            guard let image = info[.originalImage] as? UIImage else { return }
            didTakePictureManually(image: image)
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
