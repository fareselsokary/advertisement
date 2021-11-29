//
//  Content.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Foundation

// MARK: - Content

class Content: NSObject, Codable {
    var backgroundImage: String?
    var backgroundFocusPoint: String?
    var backgroundColor: String?
    var heading: String?
    var blocks: [Block]?
    var type: String?
    var id: Int?
    var products: [Product]?
    var textColor: String?
    var brands: [Brand]?

    enum CodingKeys: String, CodingKey {
        case backgroundImage
        case backgroundFocusPoint
        case backgroundColor
        case heading
        case blocks
        case type
        case id
        case products
        case textColor
        case brands
    }

    init(backgroundImage: String?, backgroundFocusPoint: String?, backgroundColor: String?, heading: String?, blocks: [Block]?, type: String?, id: Int?, products: [Product]?, textColor: String?, brands: [Brand]?) {
        self.backgroundImage = backgroundImage
        self.backgroundFocusPoint = backgroundFocusPoint
        self.backgroundColor = backgroundColor
        self.heading = heading
        self.blocks = blocks
        self.type = type
        self.id = id
        self.products = products
        self.textColor = textColor
        self.brands = brands
    }
}
