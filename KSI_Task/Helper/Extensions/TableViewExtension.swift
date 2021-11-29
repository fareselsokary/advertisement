//
//  TableViewExtension.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

extension UITableView {
    func reloadWithoutAnimation() {
        UIView.setAnimationsEnabled(false)
        beginUpdates()
        endUpdates()
        UIView.setAnimationsEnabled(true)
    }

    func scrollToBottom(animated: Bool = false) {
        if numberOfSections > 0, numberOfRows(inSection: numberOfSections - 1) - 1 > 0 {
            let iPath = IndexPath(row: numberOfRows(inSection: numberOfSections - 1) - 1,
                                  section: numberOfSections - 1)
            scrollToRow(at: iPath, at: .bottom, animated: animated)
        }
    }
}
