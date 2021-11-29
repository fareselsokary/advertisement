//
//  NetworkManager.swift
//  KSI_Task
//
//  Created by fares elsokary on 12/11/2021.
//

import Alamofire
import Foundation
import Reachability
import RxSwift

class NetworkManager {
    static let shared = NetworkManager()
    private init() {
        setupInternetConnectionListener()
    }

    fileprivate var reachability: Reachability?

    func isInternetAvailable() -> Bool {
        return (NetworkReachabilityManager()?.isReachable)!
    }
}

// MARK: - process api reqest

extension NetworkManager {
    func processReq<T>(url: String, method: HTTPMethod, returnType: T.Type, headers: HTTPHeaders? = nil, params: Alamofire.Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, repeatIfFailed: Bool = true) -> Observable<T?> where T: Codable {
        let objResponse = PublishSubject<T?>()
        sendRequest(url: url, method: method, objResponse: objResponse, headers: headers, params: params, encoding: encoding, repeatIfFailed: repeatIfFailed)
        return objResponse
    }

    private func sendRequest<T>(url: String, method: HTTPMethod, objResponse: PublishSubject<T?>, headers: HTTPHeaders? = nil, params: Alamofire.Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, repeatIfFailed: Bool) where T: Codable {
        if NetworkManager.shared.isInternetAvailable() {
            AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers).validate().responseJSON { [weak self] response in
                switch response.result {
                case .success:
                    self?.parseResponse(data: response.data, objResponse: objResponse)
                case let .failure(error):
                    print("failed url: \(url)")
                    if error._code == 13 {
                        if repeatIfFailed {
                            self?.sendRequest(url: url, method: method, objResponse: objResponse, headers: headers, params: params, encoding: encoding, repeatIfFailed: repeatIfFailed)
                        } else {
                            self?.handleError(error: .serverError, data: response.data, objResponse: objResponse)
                        }
                    } else if error._code == NSURLErrorTimedOut {
                        self?.handleError(error: .noInternet, data: response.data, objResponse: objResponse)
                    } else {
                        let errorCode = NetworkErrorType(rawValue: response.response?.statusCode ?? 500) ?? .serverError
                        self?.handleError(error: errorCode, data: response.data, objResponse: objResponse)
                    }
                }
            }
        } else {
            handleError(error: .noInternet, data: nil, objResponse: objResponse)
        }
    }
}

// MARK: - parse response JSON

extension NetworkManager {
    fileprivate func parseResponse<T>(data: Data?, returnType: T.Type) -> T? where T: Codable {
        var response: T? = nil
        if let _ = data {
            do {
                response = try JSONDecoder().decode(T.self, from: data!)
            } catch {
                response = nil
                print(error)
            }
        }
        return response
    }

    fileprivate func parseResponse<T>(data: Data?, objResponse: PublishSubject<T?>) where T: Codable {
        if let _ = data {
            do {
                let response = try JSONDecoder().decode(T.self, from: data!)
                objResponse.onNext(response)
                objResponse.onCompleted()
            } catch let error {
                print(error)
                handleError(error: .couldNotParseJson, data: data, objResponse: objResponse)
            }
        }
    }
}

// MARK: - handle Error

extension NetworkManager {
    func handleError<T>(error: NetworkErrorType, data: Data?, objResponse: PublishSubject<T?>) {
        objResponse.onNext(nil)
        let errorReponse = parseResponse(data: data, returnType: BaseResponse<NetworkErrorResponse>.self)
        objResponse.onError(NetWorkError(errorType: error, error: errorReponse))
        objResponse.onCompleted()
    }
}

extension NetworkManager {
    func setupInternetConnectionListener() {
        if reachability != nil {
            reachability?.stopNotifier()
            reachability = nil
        }
        reachability = try! Reachability()
        reachability?.whenReachable = { _ in
            NotificationCenter.default.post(name: Notification.Name.hasNetworkConnection, object: nil)
        }
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            NotificationCenter.default.post(name: Notification.Name.noNetworkConnection, object: nil)
        }
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
