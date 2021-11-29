//
//  ServiceType.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import Foundation

class ServiceType {
    var networkManager = NetworkManager.shared

    func getFullUrl(baseUrl: String, endPoint: EndPointUrls, parameters: [String: String]? = nil) -> String {
        let urlString = "\(baseUrl)\(endPoint.rawValue)"
        var components = URLComponents()
        components.path = urlString
        components.queryItems = []
        if let params = parameters {
            for key in params.keys {
                components.queryItems?.append(URLQueryItem(name: key, value: params[key]!))
            }
            return (components.url?.absoluteString.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString)
        }
        return urlString
    }

    func getFullUrl(baseUrl: String, endPoint: String, parameters: [String: String]? = nil) -> String {
        let urlString = "\(baseUrl)\(endPoint)"
        var components = URLComponents()
        components.path = urlString
        components.queryItems = []
        if let params = parameters {
            for key in params.keys {
                components.queryItems?.append(URLQueryItem(name: key, value: params[key]!))
            }
            return (components.url?.absoluteString.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString)
        }
        return urlString
    }

    func getFullUrl(baseUrl: String, endPoint: EndPointUrls, byAppending items: [String]) -> String {
        let urlString = "\(baseUrl)\(endPoint.rawValue)"
        let fullUrl = String(format: urlString, arguments: items)
        return fullUrl
    }
}
