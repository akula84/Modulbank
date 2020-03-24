//
//  UIView+Utils.swift
//  MPM
//
//  Created by Alex Kozin on 05.07.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import CoreGraphics
import UIKit

extension UIView {
    func changeHeight(newHeight: CGFloat) {
        let origin = frame.origin
        let size = frame.size
        frame = CGRect(x: origin.x, y: origin.y, width: size.width, height: newHeight)
    }

    func originY(append: CGFloat) {
        frame.origin.y += append
    }

    func pinToSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: insets.right),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom),
        ])
    }

    func animateConstrains(withDuration duration: TimeInterval = 0.3, animations: @escaping () -> Void, completion: (() -> Void)? = nil) {
        layoutIfNeeded()

        UIView.animate(withDuration: duration, animations: {
            animations()
            self.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }

    var firstTopConstraint: NSLayoutConstraint? {
        for con in constraints {
            if con.firstAttribute == .top,
                con.secondAttribute == .top,
                let secondItem = con.secondItem,
                ObjectIdentifier(secondItem) == ObjectIdentifier(self) {
                return con
            }
        }
        return nil
    }

    func loadNibView(_ nibNamed: String?) -> UIView? {
        guard let nibNamed = nibNamed else {
            return nil
        }
        return UINib(nibName: nibNamed, bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
    }

    func insertNibView(_ nibNamed: String? = nil) {
        let name = nibNamed ?? String(describing: type(of: self))
        guard let nibView = loadNibView(name) else {
            return
        }
        insertSubview(nibView, at: 0)
        nibView.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: nibView, attribute: $0, relatedBy: .equal, toItem: nibView.superview, attribute: $0, multiplier: 1, constant: 0)
        })
    }

    var sizeFitHeight: CGFloat {
        let maxWidth = frame.size.width
        return sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)).height
    }

    func removeAllGestureRecognizers() {
        gestureRecognizers?.forEach { self.removeGestureRecognizer($0) }
    }
}
