//
//  ProductsTableViewCell.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxCocoa
import RxDataSources
import RxSwift

class ProductsTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: -

    private let disposeBag = DisposeBag()
    private let productsRelay = BehaviorRelay<[GeneralSection<Product>]>(value: [])

    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        bindViewModel()
        registerCell()
    }

    private func registerCell() {
        collectionView.register(UINib(nibName: ProductsCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier)
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - ConfigurableCell

extension ProductsTableViewCell: ConfigurableCell {
    func configure(data: Content?) {
        titleLabel.text = data?.heading
        productsRelay.accept([GeneralSection<Product>(identity: 0, items: data?.products ?? [])])
    }
}

// MARK: - bindViewModel

extension ProductsTableViewCell {
    private func bindViewModel() {
        // collection view
        let configureCell: (CollectionViewSectionedDataSource<GeneralSection<Product>>, UICollectionView, IndexPath, Product) -> UICollectionViewCell = { (_, cv, ip, data) -> UICollectionViewCell in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.getCellIdentifier(), for: ip) as! ProductsCollectionViewCell
            cell.configure(data: data)
            return cell
        }

        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                            reloadAnimation: .automatic,
                                                            deleteAnimation: .automatic)

        let dataSource = RxCollectionViewSectionedAnimatedDataSource<GeneralSection<Product>>(animationConfiguration: animationConfiguration, configureCell: configureCell)

        productsRelay.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.size.height - 4
        let width: CGFloat = collectionView.frame.size.width / 2.8
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
