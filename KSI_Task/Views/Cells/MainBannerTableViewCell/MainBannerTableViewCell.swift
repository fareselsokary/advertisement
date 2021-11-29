//
//  MainBannerTableViewCell.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxCocoa
import RxDataSources
import RxSwift

class MainBannerTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchTestField: UITextField!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!

    // MARK: -

    private let disposeBag = DisposeBag()
    private let blocksRelay = BehaviorRelay<[GeneralSection<Block>]>(value: [])

    // MARK: -

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        bindViewModel()
        registerCell()
        setupUI()
    }

    private func setupUI() {
        searchTestField.placeholder = "Are you looking for a product?".localized()
        searchTestField.textAlignment = LocalizationHelper.isArabic() ? .right : .left
        searchTestField.contentHorizontalAlignment = LocalizationHelper.isArabic() ? .right : .left
    }

    private func registerCell() {
        collectionView.register(UINib(nibName: BannerBlockCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: BannerBlockCollectionViewCell.reuseIdentifier)
        let layout = RTLCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - ConfigurableCell

extension MainBannerTableViewCell: ConfigurableCell {
    func configure(data: Content?) {
        bannerImage.setImage(with: data?.backgroundImage)
        if let backgroundColor = data?.backgroundColor {
            mainView.backgroundColor = UIColor(hexString: backgroundColor)
        }
        blocksRelay.accept([GeneralSection<Block>(identity: 0, items: data?.blocks ?? [])])
    }
}

// MARK: - bindViewModel

extension MainBannerTableViewCell {
    private func bindViewModel() {
        searchButton.rx.tap.bind {
            // TODO: - start search
            print("start search")
        }.disposed(by: disposeBag)
        // collection view
        let configureCell: (CollectionViewSectionedDataSource<GeneralSection<Block>>, UICollectionView, IndexPath, Block) -> UICollectionViewCell = { (_, cv, ip, data) -> UICollectionViewCell in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: BannerBlockCollectionViewCell.getCellIdentifier(), for: ip) as! BannerBlockCollectionViewCell
            cell.configure(data: data)
            return cell
        }

        let animationConfiguration = AnimationConfiguration(insertAnimation: .automatic,
                                                            reloadAnimation: .automatic,
                                                            deleteAnimation: .automatic)

        let dataSource = RxCollectionViewSectionedAnimatedDataSource<GeneralSection<Block>>(animationConfiguration: animationConfiguration, configureCell: configureCell)

        blocksRelay.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainBannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.size.height - 4
        let width: CGFloat = height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
