//
//  StringExtension.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

extension String {
    func localized() -> String {
        let path = Bundle.main.path(forResource: LocalizationHelper.getCurrentLanguage(), ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self == ""
    }
}
