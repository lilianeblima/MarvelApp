//
//  Extras.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

struct Extras: Codable {
    var collectionURI: String
    var items: [Item]
}

struct ExtraPlus: Codable {
    let id: Int
    let thumbnail: ImageObject
    let title: String
}


struct Item: Codable {
    let name: String
    let resourceURI: String
}
