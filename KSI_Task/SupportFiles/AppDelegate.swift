//
//  AppDelegate.swift
//  KSI_Task
//
//  Created by fares elsokary on 12/11/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LocalizationHelper.setCurrentLang(lang: LanguageConstants.arabic.rawValue)
        setRoot()
        return true
    }

    func setRoot() {
        let vc = UIStoryboard.Main.instantiateViewController(withIdentifier: "HomeViewController")
        window?.rootViewController = AppNavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}
