//
//  Endpoint.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var url: URL? { get }
    var query: [String: String] { get }
}

extension Endpoint {

    var base: String {
        "https://gateway.marvel.com"
    }
    
    var url: URL? {
        var urlBase = URL(string: self.base)
        var currentQuery = query
        currentQuery.merge(RequestConfig.parameters)
        urlBase?.appendQueries(queries: currentQuery.toQueryItem())
        urlBase?.appendPathComponent(self.path)

        return urlBase
    }
}

private struct RequestConfig {
    private static let privateKey = ""
    private static let publicKey = "82a9d56fcf00f2202aec2d7798b8b000"
    private static let timestamp = Date().timeIntervalSince1970.description
    private static let hash = "\(timestamp)\(privateKey)\(publicKey)".md5
    static let parameters = ["apikey": publicKey, "ts": timestamp, "hash": hash]
    static let customQuery: [String: String] = ["limit": "20"]
}
 

enum RequestEndpoint {
    case characters(customQuery: [String: String]?)
}

extension RequestEndpoint: Endpoint {
    var query: [String: String] {
        switch self {
        case .characters(let customQuery):
            var currentQuery = RequestConfig.customQuery
            if let customQuery = customQuery {
                currentQuery.merge(customQuery)
            }
            return currentQuery
        }
    }
    
    var path: String {
        switch self {
        case .characters(_):
            return "/v1/public/characters"
        }
    }
}
