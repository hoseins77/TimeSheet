//
//  UIViewExtentions.swift
//  TimeSheet
//
//  Created by Hossein Safaie on 11/13/1397 AP.
//

import UIKit

extension UIView {
    @IBInspectable var isCircular:Bool {
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.height / 2
            } else {
                self.layer.cornerRadius = 0
            }
        } get {
            if self.layer.cornerRadius == (self.frame.height / 2) {
                return true
            } else {
                return false
            }
        }
    }
}
