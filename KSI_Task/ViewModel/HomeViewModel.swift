//
//  HomeViewModel.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxCocoa
import RxSwift

class HomeViewModel {
    // MARK: - Output

    private let bannersRelay = BehaviorRelay<[GeneralSection<Banner>]>(value: [])
    var banners: Driver<[GeneralSection<Banner>]> { bannersRelay.asDriver() }

    private let errorMessageRelay = PublishRelay<String>()
    var errorMessage: Signal<String> { errorMessageRelay.asSignal() }

    private let isLoadingRelay = PublishRelay<Bool>()
    var isLoading: Signal<Bool> { isLoadingRelay.asSignal().startWith(false) }

    var emptyViewDriver: Driver<Bool> { bannersRelay.map({ ($0.first?.items.isEmpty ?? true) }).asDriver(onErrorJustReturn: false) }

    // MARK: - Properties

    private var apiService: HomeServicesType = HomeService()
    private let disposeBag = DisposeBag()

    // MARK: - get banners

    func getBanners() {
        isLoadingRelay.accept(true)
        apiService.getBanners().asObservable().subscribe(onNext: { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoadingRelay.accept(false)
                if let resp = response,
                   resp.status?.success == true {
                    self?.bannersRelay.accept([GeneralSection(identity: 0, items: resp.data?.banners ?? [])])
                }
            }
        }, onError: { [weak self] respError in
            DispatchQueue.main.async {
                self?.isLoadingRelay.accept(false)
                if let error = respError as? NetWorkError {
                    if let errorType = error.errorType {
                        if let errorMessage = error.error?.status?.message {
                            self?.errorMessageRelay.accept(errorMessage)
                        } else {
                            switch errorType {
                            case .noInternet:
                                self?.errorMessageRelay.accept("check your internet connection".localized())
                            case .couldNotParseJson, .serverError, .invalidData:
                                self?.errorMessageRelay.accept("error happen please try again later!".localized())
                            }
                        }
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
}
