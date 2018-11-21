//
//  Extension.swift
//  linphone-swift-demo
//
//  Created by Bhavesh on 14/03/18.
//  Copyright © 2018 WiAdvance. All rights reserved.
//

import Foundation
import UIKit

open class CustomSafeAreaUIViewCtrl   : UIViewController {
    
    @IBOutlet var topLayoutConstraint : NSLayoutConstraint?
    @IBOutlet weak var navBarHeight   : NSLayoutConstraint?
    
    @IBOutlet var navBar              : UIView?
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11, *) { }
        else {
            if (self.topLayoutConstraint != nil) {
                if (self.navBar != nil) {
                    self.topLayoutConstraint = self.navBar?.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0.0)
                    self.topLayoutConstraint?.isActive = true
                }
            }
        }
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.view.bounds.size.height > self.view.bounds.size.width {
            self.navBarHeight?.constant = 64
        } else {
            self.navBarHeight?.constant = 52
        }
    }
}

// MARK: - Extension String

extension String {
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /**
     Pads the left side of a string with the specified string up to the specified length.
     Does not clip the string if too long.
     
     - parameter padding:   The string to use to create the padding (if needed)
     - parameter length:    Integer target length for entire string
     - returns: The padded string
     */
    func lpad(_ padding: String, length: Int) -> (String) {
        if self.count > length {
            return self
        }
        return "".padding(toLength: length - self.count, withPad:padding, startingAt:0) + self
    }
    /**
     Pads the right side of a string with the specified string up to the specified length.
     Does not clip the string if too long.
     
     - parameter padding:   The string to use to create the padding (if needed)
     - parameter length:    Integer target length for entire string
     - returns: The padded string
     */
    func rpad(_ padding: String, length: Int) -> (String) {
        if self.count > length { return self }
        return self.padding(toLength: length, withPad:padding, startingAt:0)
    }
    /**
     Returns string with left and right spaces trimmed off.
     
     - returns: Trimmed String
     */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    /**
     Shortcut for getting length (since Swift keeps cahnging this).
     
     - returns: Int length of string
     */
    var length: Int {
        return self.count
    }
    /**
     Returns character at a specific position from a string.
     
     - parameter index:               The position of the character
     - returns: Character
     */
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    /**
     Returns substring extracted from a string at start and end location.
     
     - parameter start:               Where to start (-1 acceptable)
     - parameter end:                 (Optional) Where to end (-1 acceptable) - default to end of string
     - returns: String
     */
    func stringFrom(_ start: Int, to end: Int? = nil) -> String {
        var maximum = self.count
        
        let i = start < 0 ? self.endIndex : self.startIndex
        let ioffset = min(maximum, max(-1 * maximum, start))
        let startIndex = self.index(i, offsetBy: ioffset)
        
        maximum -= start
        
        let j = end! < 0 ? self.endIndex : self.startIndex
        let joffset = min(maximum, max(-1 * maximum, end ?? 0))
        let endIndex = end != nil && end! < self.count ? self.index(j, offsetBy: joffset) : self.endIndex
        return self.substring(with: (startIndex ..< endIndex))
    }
    /**
     Returns substring composed of only the allowed characters.
     
     - parameter allowed:             String list of acceptable characters
     - returns: String
     */
    func onlyCharacters(_ allowed: String) -> String {
        let search = allowed
        return filter({ search.contains($0) }).reduce("", { $0 + String($1) })
    }
    /**
     Simple pattern matcher. Requires full match (ie, includes ^$ implicitly).
     
     - parameter pattern:             Regex pattern (includes ^$ implicitly)
     - returns: true if full match found
     */
    func matches(_ pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: self)
    }
    
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    private static let decimalFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        return formatter
    }()
    
    private var decimalSeparator:String{
        return String.decimalFormatter.decimalSeparator ?? "."
    }
    
    func isValidDecimal(maximumFractionDigits:Int)->Bool {
        // Depends on you if you consider empty string as valid number
        guard self.isEmpty == false else {
            return true
        }
        
        // Check if valid decimal
        if let _ = String.decimalFormatter.number(from: self) {
            // Get fraction digits part using separator
            let numberComponents = self.components(separatedBy: decimalSeparator)
            let fractionDigits = numberComponents.count == 2 ? numberComponents.last ?? "" : ""
            return fractionDigits.count <= maximumFractionDigits
        }
        
        return false
    }
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
}

// MARK: - Extension UITextField

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func placeholderColor(_ color: UIColor) {
        var placeholderText = ""
        if self.placeholder != nil {
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor : color])
    }
}

extension UIViewController {
    
    @IBAction func btnBackExtemsionAction() {
        self.navigationController?.popViewController(animated: true)
    }
   
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
