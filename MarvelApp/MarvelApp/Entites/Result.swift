//
//  Result.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

struct Result: Codable {
    let code: Int
    let data: DataObject
}

struct DataObject: Codable {
    let results: [Character]
}

struct ImageObject: Codable {
    let path: String
    let `extension`: String
}
