//
//  LocalizationHelper.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

class LocalizationHelper {
    // MARK: - variables

    class func isArabic() -> Bool {
        return getCurrentLanguage() == LanguageConstants.arabic.rawValue
    }

    class func languageId() -> String {
        return LocalizationHelper.isArabic() ? "1" : "2"
    }
}

// MARK: - set Views Semantics

extension LocalizationHelper {
    fileprivate class func setViewsSemantics() {
        if LocalizationHelper.getCurrentLanguage() == LanguageConstants.arabic.rawValue {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
}

// MARK: - reset

extension LocalizationHelper {
    class func reset(_ complition: (() -> Void)? = nil) {
        (UIApplication.shared.delegate as? AppDelegate)?.setRoot()
        complition?()
    }

    class func isSameAsPrefered() -> Bool {
        return Locale.current.languageCode == LocalizationHelper.getCurrentLanguage()
    }
}

// MARK: - set Current Lang

extension LocalizationHelper {
    class func setCurrentLang(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang], forKey: LanguageConstants.appleLanguage.rawValue)
        userdef.synchronize()
        LocalizationHelper.setViewsSemantics()
    }
}

// MARK: - get Current Language

extension LocalizationHelper {
    class func getCurrentLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: LanguageConstants.appleLanguage.rawValue) as? NSArray
        let current = langArray?.firstObject as? String
        if let current = current {
            let currentWithoutLocale = String(current[..<current.index(current.startIndex, offsetBy: 2)])
            return currentWithoutLocale
        }
        return LanguageConstants.english.rawValue
    }
}
