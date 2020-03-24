//
//  NSMutableAttributedString+Utils.swift
//  MPM
//
//  Created by Артем Кулагин on 23/01/2019.
//  Copyright © 2019 Bell Integrator. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func appendOptional(_ attrString: NSAttributedString?) {
        guard let attrString = attrString else {
            return
        }
        append(attrString)
    }

    var rangeAll: NSRange {
        return NSRange(location: 0, length: length)
    }

    func append(font: UIFont?) {
        guard let font = font else {
            return
        }
        addAttributeAllRange(.font, value: font)
    }

    func append(foregroundColor: UIColor?) {
        guard let foregroundColor = foregroundColor else {
            return
        }
        addAttributeAllRange(.foregroundColor, value: foregroundColor)
    }

    func append(lineSpacing: CGFloat?) {
        guard let lineSpacing = lineSpacing else {
            return
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        addAttributeAllRange(.paragraphStyle, value: paragraphStyle)
    }

    func addAttributeAllRange(_ name: NSAttributedString.Key, value: Any) {
        addAttribute(name, value: value, range: rangeAll)
    }

    var lineBreak: NSAttributedString { "\n".attrString() }

    func insertFirstLineBreak() {
        insert("\n".attrString(), at: 0)
    }

    func appendLineBreak() {
        append("\n".attrString())
    }
}

public extension NSAttributedString {
    func height(atWidth: CGFloat) -> CGFloat {
        let rect = boundingRect(with: CGSize(width: atWidth, height: CGFloat.greatestFiniteMagnitude),
                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                context: nil)
        return ceil(rect.size.height)
    }
}
