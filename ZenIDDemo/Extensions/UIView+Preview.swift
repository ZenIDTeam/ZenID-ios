import SwiftUI
import UIKit

struct Preview<ViewType: UIView>: UIViewRepresentable {
    let view: ViewType
    init(_ view: ViewType) {
        self.view = view
    }

    func makeUIView(context: Self.Context) -> ViewType {
        view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
