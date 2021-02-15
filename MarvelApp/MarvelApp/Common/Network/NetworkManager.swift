//
//  NetworkManager.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit
import Alamofire
import Reachability

class NetworkManager {
    
    static func request<T: Decodable>(url: URL?, completion: @escaping (_ response: Response<T>) -> Void) {
        guard hasConnection() else {
            completion(.error(ErrorResponse.noConnection))
            return
        }
        
        guard let url = url else {
            completion(.error(ErrorResponse.urlFail))
            return
        }
        
        Alamofire.request(url).response { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.error(error))
                }
            } else {
                completion(.error(response.error ?? ErrorResponse.generic))
            }
        }
    }
    
    static func hasConnection() -> Bool {
        if let reachability = Reachability.forInternetConnection(), reachability.isReachableViaWiFi() || reachability.isReachableViaWWAN() {
            return true
        }
        return false
    }
}

enum Response<T> {
    case success(T)
    case error(Error)
}

extension Response {
    func map<U>(_ block: (T) throws -> U) -> Response<U> {
        switch self {
        case .success(let object):
            do {
                let newObject = try block(object)
                return .success(newObject)
            } catch let error {
                return .error(error)
            }
            
        case .error(let error):
            return .error(error)
        }
    }
}

enum ErrorResponse: Error {
    case noConnection
    case urlFail
    case generic
}

extension ErrorResponse: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .noConnection:
            return ErrorMessage.noConnection
        case .urlFail:
            return ErrorMessage.urlError
        default:
            return ErrorMessage.defaultMessage
        }
    }
}
