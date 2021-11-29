//
//  HomeService.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Foundation
import RxSwift

protocol HomeServicesType {
    func getBanners() -> Observable<BaseResponse<BannerResponse>?>
}

class HomeService: ServiceType, HomeServicesType {
    func getBanners() -> Observable<BaseResponse<BannerResponse>?> {
        let url = getFullUrl(baseUrl: BaseUrls.base, endPoint: .banners)
        return networkManager.processReq(url: url, method: .get, returnType: BaseResponse<BannerResponse>.self)
    }
}
