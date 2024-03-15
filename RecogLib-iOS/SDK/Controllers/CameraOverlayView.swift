import UIKit

final class CameraOverlayView: UIView {
    
    private let imageName: String
    
    lazy var frameImageView: UIImageView = {
        let imageView = UIImageView(image: targettingReticle)
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var targetFrame: CGRect {
        CGRect(origin: .zero, size: targettingReticle.size).rectThatFitsRect(bounds)
    }
    
    private var targettingReticle: UIImage {
        UIImage(named: imageName, in: Bundle(for: CameraOverlayView.self), compatibleWith: nil) ?? UIImage()
    }
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        setupView()
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        frameImageView.removeFromSuperview()
        frameImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(frameImageView)
        
        let padding = min(frame.width * 0.05, frame.height * 0.05)
        
        let top = frameImageView.topAnchor.constraint(equalTo: topAnchor)
        top.constant = padding
        let bottom = frameImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottom.constant = -padding
        let leading = frameImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        leading.constant = padding
        let trailing = frameImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        trailing.constant = -padding

        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

}
