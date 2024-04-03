import SwiftUI
import UIKit

@available(iOS 13.0, *)
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
            title: NSLocalizedString("nfc-not-supported-title", comment: ""),
            subtitles: [
                NSLocalizedString("nfc-not-supported-subtitle", comment: "")
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

@available(iOS 13.0.0, *)
struct NfcNotAvailablePreview: PreviewProvider {
    static var previews: some View {
        Preview(NfcNotAvailable())
    }
}

