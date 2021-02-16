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
    var comics: [ExtraPlus]?
    var series: [ExtraPlus]?
    
    var imagePath: String {
        return "\(imageObject.path).\(imageObject.extension)"
    }
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, id, description
        case imageObject = "thumbnail"
    }
    
    func convertToFavorite() -> FavoriteCharacter? {
        guard let jpegImage = image?.toData() else {
            return nil
        }
        let imageData = NSData(data: jpegImage)
        let favoriteCharacter = FavoriteCharacter(name: name, image: imageData, id: id)
        return favoriteCharacter
    }
    
    init(name: String, id: Int, imageObject: ImageObject?, description: String?, image: UIImage?, comics: [ExtraPlus]?, series: [ExtraPlus]?) {
        self.name = name
        self.id = id
        self.imageObject = imageObject ?? ImageObject(path: String(), extension: String())
        self.description = description
        self.image = image
        self.comics = comics
        self.series = series
    }
}


