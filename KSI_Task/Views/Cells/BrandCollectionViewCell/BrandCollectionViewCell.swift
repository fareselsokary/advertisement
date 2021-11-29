//
//  BrandCollectionViewCell.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets

    @IBOutlet weak var brandImageView: UIImageView!

    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - ConfigurableCell

extension BrandCollectionViewCell: ConfigurableCell {
    func configure(data: Brand) {
        brandImageView.setImage(with: data.image ?? "", indicatorType: .activity)
    }
}
