import AVFoundation
import Foundation
import RecogLib_iOS
import UIKit

open class WebViewController: UIViewController {
    var webViewOverlay: WebViewOverlay?

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        addWebViewOverlay()
        webViewOverlay?.loadOffline()
    }

    func addWebViewOverlay() {
        removeWebViewOverlay()
        let webView = WebViewOverlay()
        webView.delegate = self
        view.addSubview(webView)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        webViewOverlay = webView
    }

    func removeWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        webViewOverlay = nil
    }

    func sendEvent(_ event: String) {
        webViewOverlay?.sendEvent(event)
    }

    func didReceiveEvent(_ event: WebEvent) {
    }
}

extension WebViewController: WebEventDelegate {
    func didReceivemessage(_ message: String) {
        guard let data = message.data(using: .utf8) else {
            fatalError("Failed to decode web event")
        }
        do {
            let event = try JSONDecoder().decode(WebEvent.self, from: data)
            didReceiveEvent(event)
        } catch {
            fatalError("Failed to decode web event")
        }
    }
}

struct WebEvent: Codable {
    struct Event: Codable {
        let feature: AppFeature
        let base64: String
    }

    let previousEvent: Event
}
