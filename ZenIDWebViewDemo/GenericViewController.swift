import UIKit
import AVFoundation

struct AppEvent {
    let feature: AppFeature
    let data: String
}

typealias EventCallback = (AppEvent) -> Void

open class GenericViewController: WebViewController {
    private let configuration: ScreenConfiguration
    private let onEvent: EventCallback

    init(configuration: ScreenConfiguration, onEvent: @escaping EventCallback) {
        self.configuration = configuration
        self.onEvent = onEvent
        super.init()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        do {
            let event = try configuration.toJson()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.sendEvent(event)
            }
        } catch {
            print(error)
        }
    }

    override func didReceiveEvent(_ event: WebEvent) {
        onEvent(AppEvent(feature: event.previousEvent.feature, data: event.previousEvent.base64))
    }
}
