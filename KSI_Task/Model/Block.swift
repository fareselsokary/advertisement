//
//  Block.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxDataSources

// MARK: - Block

class Block: NSObject, Codable {
    var type: String?
    var id: Int?
    var title: String?
    var blockImage: String?
    var blockBackgroundColor: String?
    var textColor: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case type
        case id
        case title
        case blockImage
        case blockBackgroundColor
        case textColor
        case image
    }

    init(type: String?, id: Int?, title: String?, blockImage: String?, blockBackgroundColor: String?, textColor: String?, image: String?) {
        self.type = type
        self.id = id
        self.title = title
        self.blockImage = blockImage
        self.blockBackgroundColor = blockBackgroundColor
        self.textColor = textColor
        self.image = image
    }

    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(type)
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(blockImage)
        hasher.combine(blockBackgroundColor)
        hasher.combine(textColor)
        hasher.combine(image)
        let hash = hasher.finalize()
        return hash
    }
}

extension Block: IdentifiableType {
    typealias Identity = Int
    var identity: Int { hash }
}
