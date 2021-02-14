//
//  Result.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

struct Result: Codable {
    let code: Int
    var data: DataObject
    
    var existNextPagination: Bool {
        return data.allCharacters.count < data.total ? true : false
    }
    
    enum CodingKeys: String, CodingKey {
        case code, data
    }
}

struct DataObject: Codable {
    var allCharacters: [Character]
    let total: Int
    var newCharacters: [Character] = []
    
    enum CodingKeys: String, CodingKey {
        case total
        case allCharacters = "results"
    }
}

struct ImageObject: Codable {
    let path: String
    let `extension`: String
}
