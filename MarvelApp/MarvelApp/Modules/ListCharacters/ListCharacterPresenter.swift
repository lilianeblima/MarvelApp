//
//  ListCharacterPresenter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import Foundation

class ListCharacterPresenter: ViewToPresenterListCharactersProtocol {
    weak var view: PresenterToViewListCharactersProtocol?
    var interactor: PresenterToInteractorListCharactersProtocol?
    var router: PresenterToRouterListCharactersProtocol?
    
    func getNumberOfItemsInSection() -> Int {
        return interactor?.characters?.count ?? 0
    }
    
    func getCharacter(index: Int) -> Character? {
        return interactor?.characters?[index]
    }
    

    func getCharacters() {
        interactor?.getCharacters()
    }
}

extension ListCharacterPresenter: InteractorToPresenterListCharactersProtocol {
    func getCharactersSuccess(characters: [Character]) {
        //self.characters = characters
        view?.getCharactersSuccess()
    }
    
    func getCharactersFail(errorMessage: String) {
        view?.getCharactersFail(errorMessage: errorMessage)
    }
    

}
