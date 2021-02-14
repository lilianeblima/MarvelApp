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
    var image: UIImage?
    
    var imagePath: String {
        return "\(imageObject.path).\(imageObject.extension)"
    }
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, id, description
        case imageObject = "thumbnail"
    }
    
    func convertToFavorite() -> FavoriteCharacter? {
//        guard let image = image, let jpegImage = image.jpegData(compressionQuality: 0.9) else {
//            return nil
//        }
//        let imageData = NSData(data: jpegImage)
        var favoriteCharacter = FavoriteCharacter()
        favoriteCharacter.name = name
        favoriteCharacter.id = id
        return favoriteCharacter
    }
}


