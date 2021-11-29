//
//  Banner.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxDataSources

// MARK: - DataClass

class BannerResponse: Codable {
    var meta: Meta?
    var banners: [Banner]?

    enum CodingKeys: String, CodingKey {
        case meta
        case banners
    }

    init(meta: Meta?, banners: [Banner]?) {
        self.meta = meta
        self.banners = banners
    }
}

// MARK: - Banner

class Banner: NSObject, Codable {
    var type: String?
    var content: Content?

    enum CodingKeys: String, CodingKey {
        case type
        case content
    }

    init(type: String?, content: Content?) {
        self.type = type
        self.content = content
    }

    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(type)
        hasher.combine(content)
        let hash = hasher.finalize()
        return hash
    }

    var bannerType: ProductBannerType? {
        return ProductBannerType(rawValue: type ?? "")
    }
}

extension Banner: IdentifiableType {
    typealias Identity = Int
    var identity: Int { hash }
}
