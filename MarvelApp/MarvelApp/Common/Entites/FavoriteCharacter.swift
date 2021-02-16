//
//  FavoriteCharacter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit
import RealmSwift

class FavoriteCharacter: Object {
    @objc dynamic var name = String()
    @objc dynamic var image: NSData? = nil
    @objc dynamic var id = 0
    
    init(name: String, image: NSData?, id: Int) {
        self.name = name
        self.image = image
        self.id = id
    }
    
    override init() {
        
    }
}
