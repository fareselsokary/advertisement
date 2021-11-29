//
//  NetWorkError.swift
//  KSI_Task
//
//  Created by fares elsokary on 12/11/2021.
//

import Alamofire
import Foundation

enum NetworkErrorType: Int {
    case noInternet = 0
    case couldNotParseJson = 3
    case serverError = 500
    case invalidData = 422
}

struct NetWorkError: Error {
    var errorType: NetworkErrorType?
    var error: BaseResponse<NetworkErrorResponse>?
}

class NetworkErrorResponse: Codable {
    init() {}
}

