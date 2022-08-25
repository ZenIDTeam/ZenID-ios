import UIKit

final class CameraOverlayView: UIView {
    private let imageName: String
    
    lazy var frameImageView: UIImageView = {
        let imageView = UIImageView(image: targettingReticle)
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var targettingReticle: UIImage {
        UIImage(named: imageName, in: Bundle(for: CameraOverlayView.self), compatibleWith: nil) ?? UIImage()
    }
    
    init(imageName: String, frame: CGRect) {
        self.imageName = imageName
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(frameImageView)
        frameImageView.translatesAutoresizingMaskIntoConstraints = false
        let width = frameImageView.widthAnchor.constraint(equalTo: widthAnchor)
        let height = frameImageView.widthAnchor.constraint(equalTo: heightAnchor)
        width.priority = UILayoutPriority(rawValue: 750)
        height.priority = UILayoutPriority(rawValue: 750)
        NSLayoutConstraint.activate([
            width, height,
            frameImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            frameImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func setupSafeArea(layoutGuide: UILayoutGuide) {
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            frameImageView.leftAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leftAnchor, constant: padding),
            frameImageView.topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: padding)
        ])
    }
    
    public func setupImage(rect: CGRect? = nil) {
        var transform = CGAffineTransform.identity
        
        if self.frame != .zero {
            let targetFrame = (rect?.flip() ?? self.frame)
            let croppedFrame = self.frame.flip().rectThatFitsRect(targetFrame);
            let scale = croppedFrame.height / targetFrame.width
            // adding 10% and -10% to scale because of DL snapping https://support.trask.cz/browse/MRZENID-228
            if UIDevice.current.orientation == .portrait {
                transform = CGAffineTransform(rotationAngle: 90.0 * .pi / 180.0).scaledBy(x: scale * 1.10, y: scale * 1.10)
            } else {
                transform = CGAffineTransform(rotationAngle: 90.0 * .pi / 180.0).scaledBy(x: scale * 0.9 , y: scale * 0.9)
            }
        }
        
        frameImageView.layer.setAffineTransform(transform)
    }
}
