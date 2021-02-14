//
//  FavoriteInteractor.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

class FavoriteInteractor: PresenterToInteracatorFavoriteProtocol {
    var presenter: InteractorToPresenterFavoriteProtocol?
    
    var favoritesCharacters: [FavoriteCharacter] {
        return database.getAllElements()
    }
    
    let database = Database()
    
    func numberOfRowsInSection() -> Int {
        return database.getAllElements().isEmpty ? 1 : database.getAllElements().count
    }
    
    func getCustomLayout() -> UICollectionViewFlowLayout {
        return database.getAllElements().isEmpty ? CustomFlowLayout(custom: .list) : CustomFlowLayout(custom: .grid)
    }
    
    func collectionCellType() -> UICollectionViewCell.Type {
        return database.getAllElements().isEmpty ? AlertCell.self : CharacterCell.self
    }
    
    func loadFavorites() {
        
    }
}
