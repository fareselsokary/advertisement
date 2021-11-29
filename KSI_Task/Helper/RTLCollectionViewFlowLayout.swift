//
//  RTLCollectionViewFlowLayout.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
