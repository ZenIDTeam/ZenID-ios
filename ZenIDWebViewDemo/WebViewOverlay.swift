import Foundation
import WebKit

struct WebViewOverlayState {
    let page: String
    let state: String
    let frame: CGRect
}

protocol WebEventDelegate {
    func didReceivemessage(_ message: String)
}

final class WebViewOverlay: WKWebView {
    var delegate: WebEventDelegate?
    let messageHandlerScript = """
    window.AndroidInterface = {
        nextButtonPressed(data) {
            window.webkit.messageHandlers.messageHandler.postMessage(data);
        },
        backButtonPressed(data) {
            window.webkit.messageHandlers.messageHandler.postMessage(data);
        }
    };

    window.onLoad = function() { window.webkit.messageHandlers.messageHandler.postMessage("load"); }
    """

    init() {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = false
        isOpaque = false

        let script = WKUserScript(source: messageHandlerScript, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(script)
        configuration.userContentController.add(self, name: "messageHandler")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func loadOffline() {
        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        let fileUrl = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "WebSource")!
        loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)

//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.qrLogin()
//        }
    }

//
//    func loadOnline() {
//        let request = URLRequest(url: URL(string: "http://sdkdev.zenid.cz/")!)
//        load(request)
//    }
//
//    func updateState(state: WebViewOverlayState) {
//        print(state.state)
//        let rect = state.frame
//        let command = "const event = new CustomEvent('document', { detail: { page: '\(state.page)', feedback: '\(state.state)', viewPort: { topLeft: { x: \(Int(rect.minX)), y: \(Int(rect.minY)) }, bottomRight: { x: \(Int(rect.maxX)), y: \(Int(rect.maxY)) }}}});window.dispatchEvent(event);"
//        evaluateJavaScript(command, completionHandler: nil)
//    }
//
//    func qrLogin() {
//        let command = "const event = new CustomEvent('webview', { detail: { feature: 'welcome' } } ); window.dispatchEvent(event);"
//        evaluateJavaScript(command, completionHandler: nil)
//    }

    func sendEvent(_ event: String) {
        let command = "var event = new CustomEvent('webview', \(event) ); window.dispatchEvent(event);"
        evaluateJavaScript(command, completionHandler: { data, error in
            print("webView completionHandler: data: \(data), error: \(error)")
        })
    }
}

extension WebViewOverlay: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message.name: \(message.name)")
        print("message.body: \(message.body)")
        guard let body = message.body as? String else { return }
        delegate?.didReceivemessage(body)
    }
}
