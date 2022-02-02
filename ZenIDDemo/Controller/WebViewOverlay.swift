import Foundation
import WebKit

final class WebViewOverlay: WKWebView {
    
    init() {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        scrollView.backgroundColor = .clear
        isOpaque = false
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
    
}
