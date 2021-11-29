//
//  BannerBlockCollectionViewCell.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import UIKit

class BannerBlockCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets

    @IBOutlet weak var blockImageView: UIImageView!
    @IBOutlet weak var blockName: UILabel!

    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - ConfigurableCell

extension BannerBlockCollectionViewCell: ConfigurableCell {
    func configure(data: Block) {
        blockImageView.setImage(with: data.blockImage ?? "")
        blockName.text = data.title
    }
}
