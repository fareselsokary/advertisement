//
//  HomeViewController.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxDataSources
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    private var serarchBarButton: UIBarButtonItem?
    private var refreshControl = UIRefreshControl()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.getBanners()
    }
}

// MARK: - setupUI

extension HomeViewController {
    func setupUI() {
        tableView.register(UINib(nibName: MainBannerTableViewCell.getCellIdentifier(), bundle: nil),
                           forCellReuseIdentifier: MainBannerTableViewCell.getCellIdentifier())
        tableView.register(UINib(nibName: ProductsTableViewCell.getCellIdentifier(), bundle: nil), forCellReuseIdentifier: ProductsTableViewCell.getCellIdentifier())
        tableView.register(UINib(nibName: ProductsCoverTableViewCell.getCellIdentifier(), bundle: nil), forCellReuseIdentifier: ProductsCoverTableViewCell.getCellIdentifier())
        tableView.register(UINib(nibName: BrandTableViewCell.getCellIdentifier(), bundle: nil), forCellReuseIdentifier: BrandTableViewCell.getCellIdentifier())
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        serarchBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
    }

    private func bindViewModel() {
        serarchBarButton!.rx.tap.subscribe { _ in
            print("start search")
        }.disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged).delay(.seconds(1), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] in
            self?.viewModel.getBanners()
            self?.navigationItem.rightBarButtonItem = nil
        }).disposed(by: disposeBag)

        let configureCell: (TableViewSectionedDataSource<GeneralSection<Banner>>, UITableView, IndexPath, Banner) -> UITableViewCell = { (_, tv, ip, banner) -> UITableViewCell in
            switch banner.bannerType {
            case .main:
                let cell = tv.dequeueReusableCell(withIdentifier: MainBannerTableViewCell.getCellIdentifier(), for: ip) as! MainBannerTableViewCell
                cell.configure(data: banner.content)
                return cell
            case .categoryProductsSlider:
                let cell = tv.dequeueReusableCell(withIdentifier: ProductsTableViewCell.getCellIdentifier(), for: ip) as! ProductsTableViewCell
                cell.configure(data: banner.content)
                return cell
            case .productsCover:
                let cell = tv.dequeueReusableCell(withIdentifier: ProductsCoverTableViewCell.getCellIdentifier(), for: ip) as! ProductsCoverTableViewCell
                cell.configure(data: banner.content)
                return cell
            case .brandsSlider:
                let cell = tv.dequeueReusableCell(withIdentifier: BrandTableViewCell.getCellIdentifier(), for: ip) as! BrandTableViewCell
                cell.configure(data: banner.content)
                return cell
            case .none:
                return UITableViewCell()
            }
        }

        let animationConfiguration = AnimationConfiguration(insertAnimation: .fade,
                                                            reloadAnimation: .none,
                                                            deleteAnimation: .fade)
        let dataSource = RxTableViewSectionedAnimatedDataSource<GeneralSection<Banner>>(animationConfiguration: animationConfiguration, configureCell: configureCell)

        viewModel.banners
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.willDisplayCell.subscribe(onNext: { [weak self] _, indexpath in
            if indexpath.row == 0 {
                self?.navigationItem.rightBarButtonItem = nil
            }
        }).disposed(by: disposeBag)

        tableView.rx.didEndDisplayingCell.subscribe(onNext: { [weak self] _, indexpath in
            if indexpath.row == 0 && (self?.tableView.visibleCells.first(where: { $0 is MainBannerTableViewCell }) == nil) {
                self?.navigationItem.rightBarButtonItem = self?.serarchBarButton
            }
        }).disposed(by: disposeBag)

        viewModel.emptyViewDriver.asObservable()
            .subscribe(onNext: { [weak self] isEmpty in
                if isEmpty == true {
                    self?.tableView.setEmptyMessage("No data found".localized())
                } else {
                    self?.tableView.hideEmptyMessage()
                }
            }).disposed(by: disposeBag)

        viewModel.isLoading.asObservable().subscribe(onNext: { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.showSpinner(onView: self.view)
                } else {
                    self.refreshControl.endRefreshing()
                    self.removeSpinner(fromView: self.view)
                }
            }
        }).disposed(by: disposeBag)

        viewModel.errorMessage.asObservable().subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            self.alertMessage(title: "", userMessage: error)
        }).disposed(by: disposeBag)
    }
}
