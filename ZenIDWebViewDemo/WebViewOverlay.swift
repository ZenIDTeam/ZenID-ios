import Foundation
import WebKit

struct WebViewOverlayState {
    let page: String
    let state: String
    let frame: CGRect
}

final class WebViewOverlay: WKWebView {
    init() {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        isOpaque = false

        let source = "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(script)
        // register the bridge script that listens for the output
        configuration.userContentController.add(self, name: "logHandler")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadOffline() {
        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        let fileUrl = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "WebSource")!
        loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
    }

    func loadOnline() {
        let request = URLRequest(url: URL(string: "http://sdkdev.zenid.cz/")!)
        load(request)
    }

    func updateState(state: WebViewOverlayState) {
        print(state.state)
        let rect = state.frame
        let command = "const event = new CustomEvent('document', { detail: { page: '\(state.page)', feedback: '\(state.state)', viewPort: { topLeft: { x: \(Int(rect.minX)), y: \(Int(rect.minY)) }, bottomRight: { x: \(Int(rect.maxX)), y: \(Int(rect.maxY)) }}}});window.dispatchEvent(event);"
        evaluateJavaScript(command, completionHandler: nil)
    }
}

extension WebViewOverlay: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message.name: \(message.name)")
        print("message.body: \(message.body)")
    }
}
