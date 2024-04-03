import SwiftUI
import UIKit

@available(iOS 13.0, *)
final class NfcReadingError: UIView {
    init(_ errorMessage: String? = nil) {
        super.init(frame: .zero)

        if let errorMessage, !errorMessage.isEmpty {
            setupView(with: errorMessage)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(with error: String) {
        for child in subviews {
            child.removeFromSuperview()
        }

        let contentView = ImageWithLabels(
            image: UIImage(systemName: "exclamationmark.circle.fill"),
            imageColor: .red,
            title: NSLocalizedString("nfc-unexpected-error-title", comment: ""),
            subtitles: [error],
            subtitlesAlignment: .center
        )

        addSubview(contentView)
        contentView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            paddingLeft: 32,
            paddingRight: 32
        )
    }
}

@available(iOS 13.0.0, *)
struct NfcReadingErrorPreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcReadingError("Test chyby"))
    }
}
