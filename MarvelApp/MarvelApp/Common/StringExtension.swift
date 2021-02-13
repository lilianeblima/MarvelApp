//
//  StringExtension.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

extension String {
    var md5: String {
        let data = self.data(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        _ = data!.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            return CC_MD5(bytes.baseAddress, CC_LONG(data!.count), &digest)
        }
 
        return digest.reduce(into: "") { $0 += String(format: "%02x", $1) }
    }
}

extension Dictionary {
    mutating func merge(_ dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
    
    mutating func toQueryItem() -> [URLQueryItem] {
        var queries: [URLQueryItem] = []
        for (key, value) in self {
            if let key = key as? String, let value = value as? String {
                let queryItem = URLQueryItem(name: key, value: value)
                queries.append(queryItem)
            }
        }
        return queries
    }
}

extension URL {

    mutating func appendQueries(queries: [URLQueryItem]) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        urlComponents.queryItems = queries

        self = urlComponents.url ?? self
    }
}
