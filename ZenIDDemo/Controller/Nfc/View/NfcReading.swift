import SwiftUI
import UIKit

final class NfcReadingView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        
        let contentView = ImageWithLabels(
            image: UIImage(systemName: "iphone.radiowaves.left.and.right"),
            title: "Reading NFC chip",
            subtitles: [
                "Hold identity document on back of your phone and dont take it off before success confirmed"
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

struct NfcReadingViewPreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcReadingView())
    }
}
