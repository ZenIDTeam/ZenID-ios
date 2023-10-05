import UIKit

class ImageWithLabels: UIView {
    let image: UIImage
    let title: String
    let subtitles: [String]
    let imageColor: UIColor?
    let subtitlesAlignment: NSTextAlignment
    
    init(image: UIImage?, imageColor: UIColor? = nil, title: String, subtitles: [String], subtitlesAlignment: NSTextAlignment = .left) {
        self.image = image ?? UIImage()
        self.imageColor = imageColor
        self.title = title
        self.subtitles = subtitles
        self.subtitlesAlignment = subtitlesAlignment
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        if let imageColor {
            imageView.tintColor = imageColor
        }

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let labels = subtitles.map({ label($0) })
        let labelsStack = UIStackView(arrangedSubviews: labels)
        labelsStack.axis = .vertical
        labelsStack.spacing = 16

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(labelsStack)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            labelsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }

    private func label(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = subtitlesAlignment
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }
}
