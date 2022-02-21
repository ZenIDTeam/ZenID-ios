import UIKit

final class NavigationController: UINavigationController {
    var shouldRotate: Bool? = nil
    
    override var shouldAutorotate: Bool {
        shouldRotate ?? viewControllers.last!.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        viewControllers.last!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        viewControllers.last!.preferredInterfaceOrientationForPresentation
    }
}
