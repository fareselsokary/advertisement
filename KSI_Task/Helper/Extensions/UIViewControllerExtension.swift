//
//  UIViewControllerExtension.swift
//  KSI_Task
//
//  Created by fares elsokary on 12/11/2021.
//

import AVKit
import SafariServices
import UIKit

typealias ButtonCompletionBlock = (_ buttonIndex: Int) -> Void

extension UIViewController {
    func rootViewController() -> UIViewController? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController
    }

    func appDelegate() -> AppDelegate? {
        return (UIApplication.shared.delegate as? AppDelegate)
    }

    func goToLanguageSettings() {
        let alertController = UIAlertController(title: "Title", message: "Go to Settings?", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: "App-Prefs:root=Privacy&path=PREFERRED_LANGUAGE") else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { success in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func alertMessage(title: String, userMessage: String, complition: (() -> Void)? = nil) {
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: UIAlertAction.Style.default, handler: { _ in
            complition?()
        })
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }

    func twoButtonAlert(title: String, userMessage: String, okClosure: (() -> Void)? = nil) {
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok".localized(), style: UIAlertAction.Style.default, handler: { _ in
            okClosure?()
        })
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.default, handler: { _ in
            myAlert.dismiss(animated: true, completion: nil)
        })
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }

    func alertController(withTitle title: String? = nil, message: String? = nil, alertStyle style: UIAlertController.Style = .alert, withCancelButton isCancelButton: Bool = false, cancelButtonTitle: String?, buttonsTitles: [String], completionActions completionBlock: ButtonCompletionBlock? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)

        // Buttons.
        for (index, buttonTitle) in buttonsTitles.enumerated() {
            let burronAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completionBlock?(index)
            })
            alert.addAction(burronAction)
        }

        if isCancelButton {
            let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            }
            alert.addAction(cancelButton)
        }

        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func showSpinner(onView: UIView, backColor: UIColor = UIColor.black.withAlphaComponent(0)) {
        let spinnerView = UIView(frame: onView.frame)
        spinnerView.tag = ViewTags.SpinnerTag.rawValue
        spinnerView.backgroundColor = backColor
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        if onView.subviews.contains(where: { $0.tag == ViewTags.SpinnerTag.rawValue }) {
            onView.subviews.filter({ $0.tag == ViewTags.SpinnerTag.rawValue }).forEach({ $0.removeFromSuperview() })
        }
        //
        var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        if #available(iOS 12.0, *), traitCollection.userInterfaceStyle == .dark {
            blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
        }
        blurEffectView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        blurEffectView.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        spinnerView.addSubview(blurEffectView)
        blurEffectView.center = spinnerView.center
        //
        var ai = UIActivityIndicatorView()
        if #available(iOS 13, *) {
            ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            ai = UIActivityIndicatorView(style: .whiteLarge)
        }
        ai.color = .white
        ai.startAnimating()

        DispatchQueue.main.async { [weak self] in
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            onView.bringSubviewToFront(spinnerView)
            spinnerView.fillSuperView()
            self?.view.layoutIfNeeded()
            blurEffectView.center = spinnerView.center
            ai.center = spinnerView.center
            onView.isUserInteractionEnabled = false
        }
    }

    func removeSpinner(fromView: UIView) {
        DispatchQueue.main.async {
            fromView.isUserInteractionEnabled = true
            fromView.subviews.forEach({ $0.viewWithTag(ViewTags.SpinnerTag.rawValue)?.removeFromSuperview() })
        }
    }
}
