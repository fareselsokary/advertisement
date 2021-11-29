//
//  Variant.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Foundation

// MARK: - Variant

class Variant: NSObject, Codable {
    var id: Int?
    var isDefault: Bool?
    var hasStock: Bool?
    var stock: Int?
    var unlimitedStock: Bool?
    var minQty: Int?
    var maxQty: Int?
    var weight: Int?
    var dateAdded: String?
    var onSale: Bool?
    var currency: String?
    var price: Double?
    var salePrice: Double?
    var saleAmount: Double?
    var saleType: String?
    var bestSeller: Bool?
    var badge: String?
    var badgeTextColor: String?
    var badgeBackground: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isDefault
        case hasStock
        case stock
        case unlimitedStock
        case minQty
        case maxQty
        case weight
        case dateAdded
        case onSale
        case currency
        case price
        case salePrice
        case saleAmount
        case saleType
        case bestSeller
        case badge
        case badgeTextColor
        case badgeBackground
    }

    init(id: Int?, isDefault: Bool?, hasStock: Bool?, stock: Int?, unlimitedStock: Bool?, minQty: Int?, maxQty: Int?, weight: Int?, dateAdded: String?, onSale: Bool?, currency: String?, price: Double?, salePrice: Double?, saleAmount: Double?, saleType: String?, bestSeller: Bool?, badge: String?, badgeTextColor: String?, badgeBackground: String?) {
        self.id = id
        self.isDefault = isDefault
        self.hasStock = hasStock
        self.stock = stock
        self.unlimitedStock = unlimitedStock
        self.minQty = minQty
        self.maxQty = maxQty
        self.weight = weight
        self.dateAdded = dateAdded
        self.onSale = onSale
        self.currency = currency
        self.price = price
        self.salePrice = salePrice
        self.saleAmount = saleAmount
        self.saleType = saleType
        self.bestSeller = bestSeller
        self.badge = badge
        self.badgeTextColor = badgeTextColor
        self.badgeBackground = badgeBackground
    }
}
