//
//  BaseResponse.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    var data: T?
    var status: Status?

    enum CodingKeys: String, CodingKey {
        case data
        case status
    }

    init(data: T?, status: Status?) {
        self.status = status
        self.data = data
    }
}

// MARK: - Status

class Status: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var devMsg: String?
    var update: Update?

    enum CodingKeys: String, CodingKey {
        case success
        case code
        case message
        case devMsg
        case update
    }

    init(success: Bool?, code: Int?, message: String?, devMsg: String?, update: Update?) {
        self.success = success
        self.code = code
        self.message = message
        self.devMsg = devMsg
        self.update = update
    }
}

// MARK: - Update

class Update: Codable {
    var forceUpdate: Bool?
    var forceUpdateMessage: String?

    enum CodingKeys: String, CodingKey {
        case forceUpdate
        case forceUpdateMessage
    }

    init(forceUpdate: Bool?, forceUpdateMessage: String?) {
        self.forceUpdate = forceUpdate
        self.forceUpdateMessage = forceUpdateMessage
    }
}
