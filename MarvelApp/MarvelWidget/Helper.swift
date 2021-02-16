//
//  Helper.swift
//  MarvelWidgetExtension
//
//  Created by Liliane Bezerra Lima on 16/02/21.
//

import Foundation
import UIKit

struct Helper {
    static func getDatas() -> [CharacterWidget] {
        let userDefaults = UserDefaults(suiteName: "group.com.MarvelApp")
        var result: [CharacterWidget] = []
        
        for iten in 0..<3 {
            let name = userDefaults?.string(forKey: "name\(iten)") ?? "Dado não salvo"
            let imageData = userDefaults?.data(forKey: "image\(iten)") ?? Data()
            let id = userDefaults?.integer(forKey: "id\(iten)") ?? 0
            let image = UIImage(data: imageData) ?? UIImage()
            let description = userDefaults?.string(forKey: "description\(iten)") ?? "Dado não salvo"
            let character = CharacterWidget(name: name, image: image, id: id, description: description)
            result.append(character)
        }
        return result
    }
}

struct CharacterWidget: Hashable {
    let name: String
    let image: UIImage
    let id: Int
    let description: String
    
    init(name: String, image: UIImage, id: Int, description: String) {
        self.name = name
        self.image = image
        self.id = id
        self.description = description
    }
}
