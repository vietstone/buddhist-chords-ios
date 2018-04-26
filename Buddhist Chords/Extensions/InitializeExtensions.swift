//
//  InitializeExtensions.swift
//  VNA
//
//  Created by Viet Nguyen Tran on 3/30/18.
//  Copyright © 2018 FPT Software. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = UInt32(formatted, radix: 16) {
            self.init(hex: hex, alpha: alpha)
        } else {
            return nil
        }
    }
}

extension CGSize {
    init(w: CGFloat, h: CGFloat) {
        self.init(width: w, height: h)
    }
}

extension CGRect {
    init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }
}

extension UIEdgeInsets {
    
    init(t: CGFloat, l: CGFloat, b: CGFloat, r: CGFloat) {
        self.init(top: t, left: l, bottom: b, right: r)
    }
    
    init(_ size: CGFloat) {
        self.init(top: size, left: size, bottom: size, right: size)
    }
}

extension UIView {
    @objc convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
}

extension UIImageView {
    convenience init(w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: w, height: h))
    }
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
}

extension UIScrollView {
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
}

extension UIButton {
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
}

extension UITextView {
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
}
