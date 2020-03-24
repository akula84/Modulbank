//
//  String+Utils.swift
//  MPM
//
//  Created by Alexander Tarasov on 19/07/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import UIKit

extension String {
    
    func deleteSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    func addSuffix(_ suffix: String) -> String {
        guard !self.hasSuffix(suffix) else { return self }
        return String(self + suffix)
    }
    
    func height(_ font: UIFont, width: CGFloat) -> CGFloat {
        let frame = rectWithFont(font, size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return frame.height
    }
    
    func width(_ font: UIFont, height: CGFloat) -> CGFloat {
        let frame = rectWithFont(font, size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height))
        return frame.height
    }
    
    func rectWithFont(_ font: UIFont, size: CGSize) -> CGRect {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black,
                                                         .font: font ,
                                                         .paragraphStyle: style]
        return self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
    }
    
    func indexOf(_ input: String,
                 options: String.CompareOptions = .literal) -> String.Index? {
        return range(of: input, options: options)?.lowerBound
    }
    
    func lastIndexOf(_ input: String) -> String.Index? {
        return indexOf(input, options: .backwards)
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self)
    }
    
    var intValue: Int? {
        return Int(self)
    }
    
    var doubleValue: Double? {
        return Double(self)
    }
    
    var doubleNumber: NSNumber? {
        return doubleValue?.nsnumber
    }
    
    var intNumber: NSNumber? {
        return intValue?.nsnumber
    }
    
    func isValid(regularExpression: String?) -> Bool {
        guard let regularExpression = regularExpression,
            let regex = try? NSRegularExpression(pattern: regularExpression, options: .caseInsensitive),
            regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) == nil else {
            return true
        }
        return false
    }
    
    func dropFileExtension() -> String {
        return self
            .split(separator: ".")
            .dropLast()
            .joined(separator: ".")
    }
    
    func dropFirstDot() -> String {
        if self.hasPrefix(".") {
            return String(self.dropFirst())
        }
        return self
    }
    
    var fileExtension: String? {
        guard let substring =  self.split(separator: ".").last else {
            return nil
        }
        return String(substring)
    }
    
    var appendStar: String {
        return addSuffix(" *")
    }
    
    var digitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func attrString(font: UIFont? = nil) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(string: self)
        attr.append(font: font)
        return attr
    }
    
    var attrStringSystem14: NSMutableAttributedString {
        return attrString(font: .system14)
    }
    
    var attrStringSystem15: NSMutableAttributedString {
        return attrString(font: .system15)
    }
    
    var hasValue: Bool {
        return !isEmpty
    }
    
    var rError: RunError {
        return RunError(self)
    }
}

extension String {
    
    mutating func replaceOccurrences(of target: String, with replacement: String, options: String.CompareOptions = [], locale: Locale? = nil) {
        var range: Range<String.Index>?
        repeat {
            range = self.range(of: target, options: options, range: range.map { $0.lowerBound..<self.endIndex }, locale: locale)
            if let range = range {
                self.replaceSubrange(range, with: replacement)
            }
        } while range != nil
    }
    
    mutating func replace8to7ifNeed() {
        guard first == "8" else {return}
        let s = startIndex
        replaceSubrange(s...s, with: "7")
    }
    
    mutating func removeLattice() {
        replaceOccurrences(of: "#", with: "")
    }
}

extension String {
    
    var hexColor: UIColor? {
        return UIColor(hex: self)
    }
    
}
