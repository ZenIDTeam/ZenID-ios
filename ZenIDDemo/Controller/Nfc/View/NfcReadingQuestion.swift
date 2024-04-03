import SwiftUI
import UIKit

@available(iOS 13.0.0, *)
final class NfcReadingQuestion: UIView {
    init(_ title: String? = nil) {
        super.init(frame: .zero)
        
        if let title, !title.isEmpty {
            setupView(with: title)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(with title: String) {
        for child in subviews {
            child.removeFromSuperview()
        }
        
        let contentView = ImageWithLabels(
            image: UIImage(systemName: "questionmark.circle.fill"),
            imageColor: .secondaryLabel,
            title: title,
            subtitles: [],
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
struct NfcReadingQuestionPreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcReadingQuestion("Skip NFC step?"))
    }
}

