//
//  ListCharacterPresenter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import Foundation
import UIKit

class ListCharacterPresenter: ViewToPresenterListCharactersProtocol {
    weak var view: PresenterToViewListCharactersProtocol?
    var interactor: PresenterToInteractorListCharactersProtocol?
    var router: PresenterToRouterListCharactersProtocol?
        
    func getInitialCharacters() {
        interactor?.getInitialCharacters()
    }
    
    func getNumberOfItemsInSection() -> Int {
        return interactor?.result?.data.allCharacters.count ?? 1
    }
    
    func getSelectedCharacter(index: Int) -> Character? {
        return interactor?.result?.data.allCharacters[index]
    }
        
    func isNeedUpdateCharacters() {
        interactor?.isNeedUpdateCharacters()
    }
    
    func getNextCharacters() {
        interactor?.updateCharacters()
    }
    
    func changeLayoutAction() -> (title: String, customLayout: CustomLayout)? {
        return interactor?.changeLayoutAction()
    }
    
    func updateFavoriteCharacter(isFavorite: Bool, character: FavoriteCharacter?) {
        interactor?.updateFavoriteCharacter(isFavorite: isFavorite, character: character)
    }
    
    func getTitleGridButton() -> String {
        interactor?.getTitleGridButton() ?? String()
    }
    
    func pushCharacterDetail(character: Character) {
        router?.pushToCharacterDetail(on: view!, with: character)
    }
    
    func updateImageInCharacters(id: Int, image: UIImage) {
        interactor?.updateImageInCharacters(id: id, image: image)
    }
    
    func isVisibleChangeLayoutViewButton() -> Bool {
        interactor?.isVisibleChangeLayoutViewButton() ?? false
    }
    
    func action() -> ActionCell {
        interactor?.action() ?? ActionCell.showResult
    }
    
    func getLayout() -> CustomFlowLayout {
        interactor?.getLayout() ?? CustomFlowLayout(custom: .list)
    }
}

extension ListCharacterPresenter: InteractorToPresenterListCharactersProtocol {
    func successResponse() {
        view?.updateCollectionView()
    }
    
    func getCharactersFail(errorMessage: String) {
        view?.getCharactersFail(errorMessage: errorMessage)
    }
    

}
