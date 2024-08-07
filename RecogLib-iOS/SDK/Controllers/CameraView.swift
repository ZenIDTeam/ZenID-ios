import UIKit
import AVFoundation

public final class CameraView: UIView {
    
    /// Video gravity. Default value is `.resizeAspectFill`
    public var videoGravity = Defaults.videoGravity
    
    /// If set `true` it stretch view to hosting UIView bounds ignoring safe areas.
    public var ignoreSafeArea: Bool = false
    
    let statusButton = Buttons.Camera.status
    
    let instructionView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        let subView = UIView(frame: stack.bounds)
        subView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 8
        stack.insertSubview(subView, at: 0)
        return stack
    }()

    let topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private var controlView = UIView()
    
    /// Help reduce number of onLayout calls.
    private var previousFrame: CGRect = .zero
    
    private(set) var overlay: CameraOverlayView?
    
    private(set) var drawLayer: DrawingLayer?
    
    private(set) var webViewOverlay: WebViewOverlay?
    
    let cameraView = UIView()
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var showInstructionView: Bool = false {
        didSet {
            instructionView.isHidden = !showInstructionView
        }
    }
    
    /// Callback that is triggered everytime when layout is changed.
    var onLayoutChange: (() -> Void)?
    
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard previousFrame != frame else { return }
        
        ApplicationLogger.shared.Info("Overlay layout changed")
        previousFrame = frame
        overlay?.layoutIfNeeded()
        layoutLayers()
        onLayoutChange?()
    }
    
    func setup() {
        // Camera view
        addSubview(cameraView)
        
        cameraView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        // Control view
        setupControlView()

        // Top label wrapper
        let topLabelWrapper = UIView()
        topLabelWrapper.backgroundColor = .clear
        topLabelWrapper.addSubview(topLabel)
        topLabel.anchor(top: topLabelWrapper.topAnchor, 
                        left: topLabelWrapper.leftAnchor,
                        bottom: topLabelWrapper.bottomAnchor,
                        right: topLabelWrapper.rightAnchor,
                        paddingTop: 10,
                        paddingLeft: 10,
                        paddingBottom: 10,
                        paddingRight: 10)

        // Instructions view
        instructionView.addArrangedSubview(statusButton)
        instructionView.addArrangedSubview(topLabelWrapper)
        addSubview(instructionView)
        instructionView.centerX(to: cameraView)
        instructionView.centerY(to: cameraView)
        
        configurePreviewLayer()
        configureDrawingLayer()
    }
    
    func setupControlView() {
        controlView.removeFromSuperview()
        controlView = UIView()
        addSubview(controlView)
        controlView.anchor(top: cameraView.bottomAnchor,
                           left: leftAnchor,
                           bottom: superview?.bottomAnchor,
                           right: rightAnchor)
        controlView.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
    
    /// Preview layer for video feed from capture device.
    private func configurePreviewLayer() {
        guard let previewLayer else { return }
        
        previewLayer.videoGravity = videoGravity
        previewLayer.setFrameWithoutAnimation(bounds)
        cameraView.layer.addSublayer(previewLayer)
    }

    /// Visualisation v.1 drawing layer.
    private func configureDrawingLayer() {
        guard let previewLayer else { return }
        
        drawLayer?.removeFromSuperlayer()
        drawLayer = DrawingLayer()
        drawLayer?.setFrameWithoutAnimation(bounds)
        previewLayer.addSublayer(drawLayer!)
    }
    
    private func layoutLayers() {
        previewLayer?.setFrameWithoutAnimation(bounds)
        drawLayer?.setFrameWithoutAnimation(bounds)
    }
    
    /// Add or replace overlay view.
    ///
    /// - Parameters:
    ///   - newOverlay: New overlay view.
    ///   - isStatic: If `false` then the view is hidden.
    func configureOverlay(_ newOverlay: CameraOverlayView, isStatic: Bool) {
        overlay?.removeFromSuperview()
        overlay = newOverlay
        overlay?.translatesAutoresizingMaskIntoConstraints = false
        if let overlay {
            overlay.layer.setFrameWithoutAnimation(frame)
            cameraView.addSubview(overlay)
            overlay.anchor(top: cameraView.topAnchor,
                           left: cameraView.leftAnchor,
                           bottom: cameraView.bottomAnchor,
                           right: cameraView.rightAnchor)
            overlay.isHidden = !isStatic
            overlay.layoutIfNeeded()
        }
    }
    
    // MARK: - Visualisation v.2
    
    func addWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        let webView = WebViewOverlay()
        webView.loadOnline()
        addSubview(webView)
        leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        webViewOverlay = webView
    }
    
    func removeWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        webViewOverlay = nil
    }
}
