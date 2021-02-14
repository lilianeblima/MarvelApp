//
//  FavoriteProtocol.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

protocol ViewToPresenterFavoriteProtocol: class {
    var view: PresenterToViewFavoriteProtocol? { get set }
    var interactor: PresenterToInteracatorFavoriteProtocol? { get set }
    var router: PresenterToRouterFavoriteProtocol? { get set }
    
    func numberOfRowsInSection() -> Int
    func collectionCellType() -> UICollectionViewCell.Type
    func getCustomLayout() -> UICollectionViewFlowLayout
    func getSelectedFavoriteCharacter(index: Int) -> FavoriteCharacter?
    func refresh()
    func removeFavoriteIten(favorite: FavoriteCharacter?)
}

protocol PresenterToInteracatorFavoriteProtocol: class {
    var presenter: InteractorToPresenterFavoriteProtocol? { get set }
    func numberOfRowsInSection() -> Int
    func collectionCellType() -> UICollectionViewCell.Type
    func getCustomLayout() -> UICollectionViewFlowLayout
    var favoritesCharacters: [FavoriteCharacter] { get }
    func refresh()
    func removeFavoriteIten(favorite: FavoriteCharacter?)
}

protocol InteractorToPresenterFavoriteProtocol: class {
    func refreshData()
    func showAlert(withTitle: String, andMessage: String)
}

protocol PresenterToViewFavoriteProtocol: class {
    func refresh()
    func showAlert(withTitle: String, andMessage: String)
}

protocol PresenterToRouterFavoriteProtocol: class {
    static func createModule() -> UIViewController
}
