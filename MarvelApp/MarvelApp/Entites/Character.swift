//
//  Character.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

struct Character: Codable {
    let name: String
    private let imageObject: ImageObject
    let id: Int
    let description: String?
    
    var image: String {
        return "\(imageObject.path).\(imageObject.extension)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, id, description
        case imageObject = "thumbnail"
    }
}


