//
//  BrandTableViewCell.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxCocoa
import RxDataSources
import RxSwift

class BrandTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    private let disposeBag = DisposeBag()
    private let brandsRelay = BehaviorRelay<[GeneralSection<Brand>]>(value: [])

    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        bindViewModel()
        registerCell()
    }

    private func registerCell() {
        collectionView.register(UINib(nibName: BrandCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: BrandCollectionViewCell.reuseIdentifier)
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - ConfigurableCell

extension BrandTableViewCell: ConfigurableCell {
    func configure(data: Content?) {
        titleLabel.text = data?.heading
        brandsRelay.accept([GeneralSection<Brand>(identity: 0, items: data?.brands ?? [])])
    }
}

// MARK: - bindViewModel

extension BrandTableViewCell {
    private func bindViewModel() {
        // collection view
        let configureCell: (CollectionViewSectionedDataSource<GeneralSection<Brand>>, UICollectionView, IndexPath, Brand) -> UICollectionViewCell = { (_, cv, ip, data) -> UICollectionViewCell in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.getCellIdentifier(), for: ip) as! BrandCollectionViewCell
            cell.configure(data: data)
            return cell
        }

        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                            reloadAnimation: .automatic,
                                                            deleteAnimation: .automatic)

        let dataSource = RxCollectionViewSectionedAnimatedDataSource<GeneralSection<Brand>>(animationConfiguration: animationConfiguration, configureCell: configureCell)

        brandsRelay.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BrandTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.size.height - 4
        let width: CGFloat = height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
