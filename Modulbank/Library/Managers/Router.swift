import UIKit

typealias EmptyBlock = () -> Void

class Router {
    
    static let shared = Router()
    
    static var rootViewController: UIViewController? {
        return window??.rootViewController
    }
    
    static var window: UIWindow?? {
        return UIApplication.shared.delegate?.window
    }
    
    static func prepareRootViewController(_ viewController: UIViewController?) {
        topNavigationController?.popToRootViewController(animated: false)
        topNavigationController?.dismiss(animated: false, completion: nil)
        rootViewController?.dismiss(animated: true, completion: nil)
        window??.rootViewController = viewController
    }
    
    static func present(_ viewControllerToPresent: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let viewControllerToPresent = viewControllerToPresent,
            var viewController: UIViewController = rootViewController else {
                return
        }
        
        while let presented = viewController.presentedViewController {
            viewController = presented
        }
        viewControllerToPresent.modalPresentationStyle = .overCurrentContext
        viewController.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    static func topViewController(_ base: UIViewController? = rootViewController, excludeAlert: Bool = false) -> UIViewController? {
        if let nav = base as? UINavigationController {
            let vc = nav.visibleViewController
            if excludeAlert, vc is UIAlertController {
                return base
            }
            return topViewController(vc)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    static var topNavigationController: UINavigationController? {
        let vc = topViewController(excludeAlert: true)
        guard let nav = vc as? UINavigationController else {
            return vc?.navigationController
        }
        return nav
    }
    
    static func dismissTopViewController(completion: EmptyBlock? = nil, animated: Bool = true) {
        topViewController()?.dismiss(animated: animated, completion: completion)
    }
    
    static func topView(excludeAlert: Bool = false) -> UIView? {
        return topViewController(excludeAlert: excludeAlert)?.view
    }
    
    static func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
         topNavigationController?.pushViewController(viewController, animated: animated)
    }
    
    static func popViewController(animated: Bool = true) {
        topNavigationController?.popViewController(animated: animated)
    }
}

extension Router {
    static func showLoader() {
        topViewController()?.setLoading(true)
    }
    
    static func removeLoader() {
        topViewController()?.setLoading(false)
    }
}
