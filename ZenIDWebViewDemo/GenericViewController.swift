import AVFoundation
import UIKit

typealias EventCallback = (WebEvent) -> Void

open class GenericViewController: WebViewController {
    private let configuration: JsonConvertible
    private let onEvent: EventCallback

    init(configuration: JsonConvertible, onEvent: @escaping EventCallback) {
        self.configuration = configuration
        self.onEvent = onEvent
        super.init()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        do {
            let event = try configuration.toJson()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.sendEvent(event)
            }
        } catch {
            print(error)
        }
    }

    override func didReceiveEvent(_ event: WebEvent) {
        // onEvent(AppEvent(feature: event.previousEvent.feature, data: event.previousEvent.base64))
        onEvent(event)
    }
}
