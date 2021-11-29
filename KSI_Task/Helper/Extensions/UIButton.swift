//
//  UIButton.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

@IBDesignable
extension UIButton {
    @IBInspectable var localizationKey: String {
        set {
            setTitle(newValue.localized(), for: .normal)
        }
        get {
            return (titleLabel?.text)!
        }
    }
}
