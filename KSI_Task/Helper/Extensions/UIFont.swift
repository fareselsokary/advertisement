//
//  UIFont.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

extension UIFont {
    static func printAllFonts() {
        for family in UIFont.familyNames {
            let sName: String = family as String
            print("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }

    static func appFont(ofSize size: CGFloat, weight: FontName) -> UIFont {
        let fontName: String
        switch weight {
        case .regular:
            fontName = "Cairo-Regular"
        case .extraLight:
            fontName = "Cairo-ExtraLight"
        case .light:
            fontName = "Cairo-Light"
        case .bold:
            fontName = "Cairo-Bold"
        case .semiBold:
            fontName = "Cairo-SemiBold"
        case .black:
            fontName = "Cairo-Black"
        }

        return UIFont(name: fontName, size: size)!
    }
}
