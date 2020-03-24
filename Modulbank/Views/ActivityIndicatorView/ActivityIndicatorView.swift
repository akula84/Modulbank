//
//  ActivityIndicator.swift
//  KhalyavaGo
//
//  Created by Дмитрий on 07.06.2018.
//  Copyright © 2018 Khalyava Go. All rights reserved.
//

import SnapKit
import UIKit

final class ActivityIndicatorView: UIView {
    private(set) lazy var indicator: UIActivityIndicatorView = {
        var style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            style = .large
        } else {
            style = .whiteLarge
        }
        return UIActivityIndicatorView(style: style)
    }()

    lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()

    init() {
        super.init(frame: .zero)
        addSubview(backgroundView)
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicator.color = .white
        backgroundView.backgroundColor = .white
        backgroundView.alpha = 0.6
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        guard superview != nil else { return }
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func showLoader() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self)
            window.bringSubviewToFront(self)
        }
        isHidden = false
        backgroundView.isHidden = false
        indicator.startAnimating()
        isUserInteractionEnabled = true
    }

    func hideLoader() {
        removeFromSuperview()
        isHidden = true
        backgroundView.isHidden = true
        indicator.stopAnimating()
        isUserInteractionEnabled = false
    }
}
