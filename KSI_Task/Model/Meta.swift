//
//  Meta.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Foundation

// MARK: - Meta

class Meta: Codable {
    var pageNumber: Int?
    var pageLimit: Int?
    var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case pageNumber
        case pageLimit
        case totalPages
    }

    init(pageNumber: Int?, pageLimit: Int?, totalPages: Int?) {
        self.pageNumber = pageNumber
        self.pageLimit = pageLimit
        self.totalPages = totalPages
    }
}
