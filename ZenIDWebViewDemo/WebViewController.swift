import AVFoundation
import Foundation
import RecogLib_iOS
import UIKit

open class WebViewController: UIViewController {
    var webViewOverlay: WebViewOverlay!
    var loadingView: UIView!

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        addWebViewOverlay()
        webViewOverlay?.loadOffline()
        addLoadingView()
    }

    func addWebViewOverlay() {
        removeWebViewOverlay()
        let webView = WebViewOverlay()
        webView.delegate = self
        view.addSubview(webView)
        webView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        webViewOverlay = webView
        webViewOverlay.isHidden = true
    }

    func addLoadingView() {
        if let loadingView {
            loadingView.removeFromSuperview()
            self.loadingView = nil
        }

//        let loadingView = UIView()
//        loadingView.backgroundColor = .white
//        view.addSubview(loadingView)
//        self.loadingView = loadingView
    }

    func removeWebViewOverlay() {
        webViewOverlay?.removeFromSuperview()
        webViewOverlay = nil
    }

    func sendEvent(_ event: String) {
        webViewOverlay?.sendEvent(event)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            if let webViewOverlay  = self?.webViewOverlay {
                self?.setView(view: webViewOverlay, hidden: false)
            }
        }
    }

    func didReceiveEvent(_ event: WebEvent) {
    }

    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
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

struct WebEvent: Decodable {
    struct PreviousEvent: Decodable {
        let feature: AppFeature
        let role: String?

        init(feature: AppFeature, role: String? = nil) {
            self.feature = feature
            self.role = role
        }
    }

    struct NextEvent: Decodable {
        let feature: AppFeature?
        let role: String?
        let data: SettingsData?
    }

    let previousEvent: PreviousEvent
    let nextEvent: NextEvent?
}

struct SettingsData: Decodable {
    struct DocumentsVerifierSettings: Decodable {
        let specularAcceptableScore: String
        let documentBlurAcceptableScore: String
        let timeToBlurMaxTolerance: String
        let showTimer: String
    }

    struct ColorsSettins: Decodable {
        let primaryColor: String
        let contrastColor: String
    }

    let country: String
    let selfieVerification: String
    let DocumentsFilter: [String]
    let DocumentsVerifier: DocumentsVerifierSettings
    let Colors: ColorsSettins
    let debugMode: String
}
