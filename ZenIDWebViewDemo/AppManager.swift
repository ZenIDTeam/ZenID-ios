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

    func showHome() {
        let vc = GenericViewController(configuration: ScreenConfiguration(feature: .home), onEvent: handleAppEvent)
        navigationController.viewControllers = [vc]
    }

    func showFeatureScreen(_ feature: AppFeature) {
        let vc = GenericViewController(configuration: ScreenConfiguration(feature: feature), onEvent: handleAppEvent)
        navigationController.viewControllers = [vc]
    }

    func showDocumentPromoScreen(role: DocumentScreenConfiguration.Detail.Role) {
        let vc = GenericViewController(configuration: DocumentScreenConfiguration(role: role, page: nil, feedback: nil), onEvent: handleDocumentPromoEvents)
        navigationController.viewControllers = [vc]
    }

    func showDocumentScanScreen(role: DocumentScreenConfiguration.Detail.Role, page: DocumentScreenConfiguration.Detail.Page, feedback: String? = nil) {
        let vc = GenericViewController(configuration: DocumentScreenConfiguration(role: role, page: page, feedback: feedback), onEvent: handleDocumentScanEvents)
        navigationController.viewControllers = [vc]
    }
}

// handle events
extension AppManager {
    func handleAppEvent(_ event: WebEvent) {
        DispatchQueue.main.async { [weak self] in

            switch event.previousEvent.feature {
            case .welcome:
                self?.swowQrCodeSetup()
            case .scan:
                self?.showFeatureScreen(.home)
            case .home:
                if let next = event.nextEvent, let feature = next.feature {
                    switch feature {
                    case .document:
                        guard let rawRole = next.role,
                              let role = DocumentScreenConfiguration.Detail.Role(rawValue: rawRole) else { return }
                        self?.showDocumentPromoScreen(role: role)
                    default:
                        break
                    }
                }
            case .document:
                break

            case .settings:
                if let next = event.nextEvent, let data = next.data {
                    print(data)
                }
                self?.showFeatureScreen(.home)
            }
        }
    }

    func handleDocumentPromoEvents(_ event: WebEvent) {
        guard let rawRole = event.previousEvent.role, let role = DocumentScreenConfiguration.Detail.Role(rawValue: rawRole) else { return }
        showDocumentScanScreen(role: role, page: .F)
    }

    func handleDocumentScanEvents(_ event: WebEvent) {
        showFeatureScreen(.home)
    }

    func handleQREvents(_ event: QRViewEvent) {
        DispatchQueue.main.async { [weak self] in
            switch event {
            case .qrAuthorized(let code):
                print("authorized, open next screen")
                self?.showHome()
            case .qrFailed:
                print("authoruzation failed")
            }
        }
    }
}
