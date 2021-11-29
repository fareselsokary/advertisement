//
//  ProductsCollectionViewCell.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxSwift

class ProductsCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets

    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceOfferLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: -

    private let disposeBag = DisposeBag()

    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        bindViewModel()
    }
}

// MARK: - ConfigurableCell

extension ProductsCollectionViewCell: ConfigurableCell {
    func configure(data: Product) {
        let defaultVariant = data.variants?.first(where: { $0.isDefault == true }) ?? data.variants?.first
        badgeLabel.text = defaultVariant?.badge
        badgeView.isHidden = defaultVariant?.badge?.isBlank ?? true
        productImage.setImage(with: data.image ?? "")
        brandLabel.text = data.brand
        priceLabel.text = "\(defaultVariant?.salePrice ?? 0) \(defaultVariant?.currency ?? "")"
        titleLabel.text = data.title
        setupOfferLabel(variant: defaultVariant)
    }

    private func setupOfferLabel(variant: Variant?) {
        guard variant?.onSale == true else {
            priceOfferLabel.isHidden = true
            return
        }
        let salePriceFont = UIFont.appFont(ofSize: 12, weight: .semiBold)
        let saleAmountFont = UIFont.appFont(ofSize: 12, weight: .bold)
        // add sale price attribute
        let salePriceAttributes: [NSAttributedString.Key: Any] = [.font: salePriceFont,
                                                                  .foregroundColor: UIColor.black,
                                                                  .strikethroughStyle: NSUnderlineStyle.single.rawValue]
        let attributedSalePrice = NSMutableAttributedString(string: "\(variant?.price ?? 0)", attributes: salePriceAttributes)

        // add currency attribute
        let currncyAttributes: [NSAttributedString.Key: Any] = [.font: salePriceFont,
                                                                .foregroundColor: UIColor.black]
        let attributedCurrncy = NSMutableAttributedString(string: " " + (variant?.currency ?? ""), attributes: currncyAttributes)

        // add sale percenage  attribute
        let saleAmountAttributes: [NSAttributedString.Key: Any] = [.font: saleAmountFont,
                                                                   .foregroundColor: UIColor.orange]
        let attributedSaleAmount = NSMutableAttributedString(string: " \(variant?.saleAmount ?? 0)% \("discount".localized())", attributes: saleAmountAttributes)

        attributedSalePrice.append(attributedCurrncy)
        attributedSalePrice.append(attributedSaleAmount)
        priceOfferLabel.attributedText = attributedSalePrice
    }
}

// MARK: - bindViewModel

extension ProductsCollectionViewCell {
    private func bindViewModel() {
        addToCartButton.rx.tap.bind {
            // TODO: - add to cart action
            print("add to cart action")
        }.disposed(by: disposeBag)
    }
}
