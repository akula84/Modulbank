//
//  UIViewController+Storyboards.swift
//  Day
//
//  Created by Alexander Kozin on 12.05.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import UIKit

extension UIViewController {
    static func inNavigationStack() -> UIViewController {
        return UINavigationController(rootViewController: controller())
    }

    static func controller() -> Self {
        func controller<T>(_ type: T.Type) -> T? {
            return storyboard().instantiateViewController(withIdentifier: storyboardIdentifier()) as? T
        }
        return controller(self) ?? self.init()
    }

    class func storyboard() -> UIStoryboard {
        return UIStoryboard(name: storyboardName(), bundle: Bundle(for: self))
    }

    @objc
    class func storyboardName() -> String {
        return storyboardIdentifier()
    }

    @objc
    class func storyboardIdentifier() -> String {
        return Utils.stringFromSwiftClass(self)
    }

    @objc
    func backAction() {
        let popped = navigationController?.popViewController(animated: true)
        if popped == nil {
            dismiss()
        }
    }
}

public class Utils {
    static func stringFromSwiftClass(_ swiftClass: AnyClass) -> String {
        return NSStringFromClass(swiftClass).components(separatedBy: ".").last!
    }
}


extension UIViewController {
    @objc
    func dismiss(completion: (() -> Swift.Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }

    func presentOverCurrentContext(_ viewControllerToPresent: UIViewController?, animated flag: Bool, completion: (() -> Void)? = nil) {
        guard let vc = viewControllerToPresent else { return }
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: flag, completion: completion)
    }
}
