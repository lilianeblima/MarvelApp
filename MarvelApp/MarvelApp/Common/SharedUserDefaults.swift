//
//  SharedUserDefaults.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 16/02/21.
//

import UIKit


struct SharedUserDefaults {
    static let suitName = "group.com.MarvelApp"
    static let idKey = "id="
    static let nameKey = "name"
    static let descriptionKey = "description"
    static let imageKey = "image"
    
    
    static func save(value: String, key: String) {
        let userDefault = UserDefaults(suiteName: suitName)
        userDefault?.setValue(value, forKey: key)
    }
    
    static func getCharacter(withData data: String?) -> Character? {
        let userDefault = UserDefaults(suiteName: suitName)
        if let data = data, data.contains(idKey), let id = Int(data.replacingOccurrences(of: idKey, with: String())) {
            let name = userDefault?.string(forKey: "\(nameKey)\(id)") ?? String()
            let description = userDefault?.string(forKey: "\(descriptionKey)\(id)") ?? String()
            let imageData = userDefault?.data(forKey: "\(imageKey)\(id)") ?? Data()
            let image = UIImage(data: imageData) ?? UIImage()

            let character = Character(name: name, id: id, imageObject: nil, description: description, image: image, comics: nil, series: nil)
            
            return character
        }
        return nil
    }
}
