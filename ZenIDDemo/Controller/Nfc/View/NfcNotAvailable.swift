import SwiftUI
import UIKit

final class NfcNotAvailable: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        
        let contentView = ImageWithLabels(
            image: UIImage(systemName: "exclamationmark.circle.fill"),
            imageColor: .red,
            title: "NFC reader is not supported",
            subtitles: [
                "Choose another type of verifiation"
            ],
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

struct NfcNotAvailablePreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcNotAvailable())
    }
}

