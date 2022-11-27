import UIKit

protocol AppManagerDelegate {
    func sendEvent(source: AppFeature, data: String)
}

class AppManager {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showWelcome()
    }

    func showWelcome() {
        let vc = GenericViewController(configuration: ScreenConfiguration(feature: .welcome), onEvent: handleAppEvent)
        navigationController.viewControllers = [vc]
    }

    func swowQrCodeSetup() {
        let vc = QRCodeViewController(onEvent: handleAppEvent)
        navigationController.viewControllers = [vc]
    }

    func handleAppEvent(_ event: AppEvent) {
        switch event.feature {
        case .welcome:
            swowQrCodeSetup()
        case .scan:
            break
        }
    }
}
