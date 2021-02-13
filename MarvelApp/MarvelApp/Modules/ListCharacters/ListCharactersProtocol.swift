//
//  ListCharactersProtocol.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 13/02/21.
//

import UIKit

protocol ViewToPresenterListCharactersProtocol: class {
    var view: PresenterToViewListCharactersProtocol? { get set }
    var interactor: PresenterToInteractorListCharactersProtocol? { get set }
    var router: PresenterToRouterListCharactersProtocol? { get set }
    func getCharacters()
    func getNumberOfItemsInSection() -> Int
    func getCharacter(index: Int) -> Character?
    
}

protocol PresenterToViewListCharactersProtocol: class {
    func getCharactersSuccess()
    func getCharactersFail(errorMessage: String)
}


protocol PresenterToInteractorListCharactersProtocol: class {
    var presenter: InteractorToPresenterListCharactersProtocol? { get set }
    func getCharacters()
    var characters: [Character]? {get}
}

protocol InteractorToPresenterListCharactersProtocol: class {
    func getCharactersSuccess(characters: [Character])
    func getCharactersFail(errorMessage: String)
}

protocol PresenterToRouterListCharactersProtocol: class {
    static func createModule() -> UIViewController
}
