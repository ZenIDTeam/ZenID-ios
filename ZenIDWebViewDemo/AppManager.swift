import UIKit

protocol AppManagerDelegate {
    func sendEvent(source: AppFeature, data: String)
}

class AppManager {
    private let navigationController: UINavigationController
    private let rootViewController: GenericViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        rootViewController = GenericViewController()
    }

    func start() {
        rootViewController.setEventCallback(onEvent: handleAppEvent)
        navigationController.viewControllers = [rootViewController]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.showDocumentScanScreen(role: .Idc, page: .F)
            //self?.showWelcome()
        }
    }

    func showWelcome() {
        rootViewController.loadConfiguration(configuration: ScreenConfiguration(feature: .welcome))
//        let vc = GenericViewController(configuration: ScreenConfiguration(feature: .welcome), onEvent: handleAppEvent)
//        navigationController.viewControllers = [vc]
    }

    func swowQrCodeSetup() {
        let vc = QRCodeViewController(onEvent: handleAppEvent)
        navigationController.pushViewController(vc, animated: true)
        // navigationController.viewControllers = [vc]
    }

    func showHome() {
        rootViewController.loadConfiguration(configuration: ScreenConfiguration(feature: .home))
//        let vc = GenericViewController(configuration: ScreenConfiguration(feature: .home), onEvent: handleAppEvent)
//        navigationController.viewControllers = [vc]
    }

    func showFeatureScreen(_ feature: AppFeature) {
        rootViewController.loadConfiguration(configuration: ScreenConfiguration(feature: feature))
//        let vc = GenericViewController(configuration: ScreenConfiguration(feature: feature), onEvent: handleAppEvent)
//        navigationController.viewControllers = [vc]
    }

    func showDocumentPromoScreen(role: DocumentScreenConfiguration.Detail.Role) {
        rootViewController.loadConfiguration(configuration: DocumentScreenConfiguration(role: role, page: nil, feedback: nil))
//        let vc = GenericViewController(configuration: DocumentScreenConfiguration(role: role, page: nil, feedback: nil), onEvent: handleDocumentPromoEvents)
//        navigationController.viewControllers = [vc]
    }

    func showDocumentScanScreen(role: DocumentScreenConfiguration.Detail.Role, page: DocumentScreenConfiguration.Detail.Page, feedback: String? = nil) {
        rootViewController.loadConfiguration(configuration: DocumentScreenConfiguration(role: role, page: page, feedback: feedback))
//        let vc = GenericViewController(configuration: DocumentScreenConfiguration(role: role, page: page, feedback: feedback), onEvent: handleDocumentScanEvents)
//        navigationController.viewControllers = [vc]
    }
}

// handle events
extension AppManager {
    func handleAppEvent(_ event: WebEvent) {
        DispatchQueue.main.async { [weak self] in

            switch event.previousEvent.feature {
            case .welcome:
                self?.handleWelcomeScreenEvents(event)
            case .scan:
                self?.navigationController.popViewController(animated: false)
                self?.handleQRScanScreenEvents(event)
            case .home:
                self?.handleHomeScreenEvents(event)
            case .document:
                self?.handleDocumentScreenEvents(event)
            case .settings:
                self?.handleSettingsScreenEvents(event)
            }
        }
    }

    func handleWelcomeScreenEvents(_ event: WebEvent) {
        swowQrCodeSetup()
    }

    func handleQRScanScreenEvents(_ event: WebEvent) {
        showFeatureScreen(.home)
    }

    func handleHomeScreenEvents(_ event: WebEvent) {
        if let next = event.nextEvent, let feature = next.feature {
            switch feature {
            case .document:
                guard let rawRole = next.role,
                      let role = DocumentScreenConfiguration.Detail.Role(rawValue: rawRole) else { return }
                showDocumentPromoScreen(role: role)
            case .settings:
                showFeatureScreen(.settings)
            default:
                break
            }
        }
    }

    func handleDocumentScreenEvents(_ event: WebEvent) {
        if let rawRole = event.previousEvent.role, let role = DocumentScreenConfiguration.Detail.Role(rawValue: rawRole) {
            if let page = event.previousEvent.page {
                showFeatureScreen(.home)
                return
            }
            showDocumentScanScreen(role: role, page: .F)
        }
    }

    func handleSettingsScreenEvents(_ event: WebEvent) {
        if let next = event.nextEvent, let data = next.data {
            print(data)
        }
        showFeatureScreen(.home)
    }

//    func handleDocumentPromoEvents(_ event: WebEvent) {
//        guard let rawRole = event.previousEvent.role, let role = DocumentScreenConfiguration.Detail.Role(rawValue: rawRole) else { return }
//        showDocumentScanScreen(role: role, page: .F)
//    }
//
//    func handleDocumentScanEvents(_ event: WebEvent) {
//        showFeatureScreen(.home)
//    }
//
//    func handleQREvents(_ event: QRViewEvent) {
//        DispatchQueue.main.async { [weak self] in
//            switch event {
//            case .qrAuthorized(let code):
//                print("authorized, open next screen")
//                self?.showHome()
//            case .qrFailed:
//                print("authoruzation failed")
//            }
//        }
//    }
}
