//
//  AppNavigationController.swift
//  KSI_Task
//
//  Created by fares elsokary on 14/11/2021.
//

import UIKit

// MARK: - AppNavigationController

class AppNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                             NSAttributedString.Key.font: UIFont.appFont(ofSize: 20, weight: .bold)]
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.barTintColor = .brown
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
