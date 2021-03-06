//
//  FavoritePresenter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

class FavoritePresenter: ViewToPresenterFavoriteProtocol {
    weak var view: PresenterToViewFavoriteProtocol?
    
    var interactor: PresenterToInteracatorFavoriteProtocol?
    
    var router: PresenterToRouterFavoriteProtocol?
    

    func numberOfRowsInSection() -> Int {
        interactor?.numberOfRowsInSection() ?? 0
    }
    
    func getCustomLayout() -> UICollectionViewFlowLayout {
        interactor?.getCustomLayout() ?? CustomFlowLayout(custom: .list)
    }
    
    func collectionCellType() -> UICollectionViewCell.Type {
        return interactor?.collectionCellType() ?? AlertCell.self
    }
    
    func getSelectedFavoriteCharacter(index: Int) -> FavoriteCharacter? {
        return interactor?.favoritesCharacters[index]
    }
    
    func refresh() {
        interactor?.refresh()
    }
    
    func removeFavoriteIten(favorite: FavoriteCharacter?) {
        interactor?.removeFavoriteIten(favorite: favorite)
    }
}

extension FavoritePresenter: InteractorToPresenterFavoriteProtocol {
    func showAlert(withTitle: String, andMessage: String) {
        view?.showAlert(withTitle: withTitle, andMessage: andMessage)
    }
    
    func refreshData() {
        view?.refresh()
    }
}
