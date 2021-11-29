//
//  Product.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxDataSources

// MARK: - Product

class Product: NSObject, Codable {
    var id: Int?
    var title: String?
    var image: String?
    var brand: String?
    var rating: Double?
    var variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case brand
        case rating
        case variants
    }

    init(id: Int?, title: String?, image: String?, brand: String?, rating: Double?, variants: [Variant]?) {
        self.id = id
        self.title = title
        self.image = image
        self.brand = brand
        self.rating = rating
        self.variants = variants
    }

    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(image)
        hasher.combine(brand)
        hasher.combine(rating)
        hasher.combine(variants)
        let hash = hasher.finalize()
        return hash
    }
}

extension Product: IdentifiableType {
    typealias Identity = Int
    var identity: Int { hash }
}
