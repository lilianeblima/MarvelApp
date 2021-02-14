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
    func getInitialCharacters()
    func getNumberOfItemsInSection() -> Int
    func getSelectedCharacter(index: Int) -> Character?
    func isNeedUpdateCharacters()
}

protocol PresenterToViewListCharactersProtocol: class {
    func updateCollectionView()
    func getCharactersFail(errorMessage: String)
    func showLoadViewCell()
}


protocol PresenterToInteractorListCharactersProtocol: class {
    var presenter: InteractorToPresenterListCharactersProtocol? { get set }
    func getCharacters()
    func isNeedUpdateCharacters()
    func updateCharacters()
    var result: Result? { get }
}

protocol InteractorToPresenterListCharactersProtocol: class {
    func getCharactersSuccess()
    func getCharactersFail(errorMessage: String)
    func needUpdateCharacters()
}

protocol PresenterToRouterListCharactersProtocol: class {
    static func createModule() -> UIViewController
}
