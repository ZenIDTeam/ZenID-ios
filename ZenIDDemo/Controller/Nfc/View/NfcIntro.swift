import SwiftUI
import UIKit

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
            title: "Good to know before reading NFC",
            subtitles: [
                "• Prepare a valid personal ID",
                "• Hold identity document on back of your phone until you receive confirmation of success"
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

struct NfcIntroViewPreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcIntroView())
    }
}
