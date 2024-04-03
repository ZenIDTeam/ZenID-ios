import SwiftUI
import UIKit

@available(iOS 13.0, *)
final class NfcIntroView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        
        let contentView = ImageWithLabels(
            image: UIImage(systemName: "esim"),
            title: NSLocalizedString("nfc-intro-title", comment: ""),
            subtitles: [
                NSLocalizedString("nfc-intro-valid-id", comment: ""),
                NSLocalizedString("nfc-intro-nfc-reading", comment: "")
            ]
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
struct NfcIntroViewPreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcIntroView())
    }
}
