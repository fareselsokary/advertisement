//
//  Brand.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxDataSources

// MARK: - Brand

class Brand: NSObject, Codable {
    var id: Int?
    var image: String?
    var category: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case category
    }

    init(id: Int?, image: String?, category: Int?) {
        self.id = id
        self.image = image
        self.category = category
    }

    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        hasher.combine(image)
        hasher.combine(category)
        let hash = hasher.finalize()
        return hash
    }
}

extension Brand: IdentifiableType {
    typealias Identity = Int
    var identity: Int { hash }
}
