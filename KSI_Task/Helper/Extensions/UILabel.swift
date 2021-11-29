//
//  UILabel.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

extension UILabel {
    @IBInspectable var localizationKey: String {
        set {
            text = newValue.localized()
        }
        get {
            return text!
        }
    }
}
