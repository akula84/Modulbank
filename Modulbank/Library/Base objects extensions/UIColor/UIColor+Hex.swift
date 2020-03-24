//
//  UIColor+Hex.swift
//  MPM
//
//  Created by Артем Кулагин on 14.11.2019.
//  Copyright © 2019 Bell Integrator. All rights reserved.
//

import UIKit


extension UIColor {

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    var toHex: String? {
        guard let components = cgColor.components,
            let model = cgColor.colorSpace?.model,
            let first = components.first?.float,
            let last = components.last?.float else {
            return nil
        }
   
        let r = first
        var g: Float
        var b: Float
        let a = last
     
        switch model {
        case .monochrome:
            g = first
            b = first
        case .rgb:
            g = Float(components[1])
            b = Float(components[2])
        default:
            return nil
        }
 
        return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
    }

}
