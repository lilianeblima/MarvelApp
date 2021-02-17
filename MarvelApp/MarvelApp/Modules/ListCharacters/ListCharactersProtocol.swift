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
    func changeLayoutAction() -> (title: String, customLayout: CustomLayout)?
    func updateFavoriteCharacter(isFavorite: Bool, character: FavoriteCharacter?)
    func getTitleGridButton() -> String 
    func pushCharacterDetail(character: Character)
    func updateImageInCharacters(id: Int, image: UIImage)
    func isVisibleChangeLayoutViewButton() -> Bool
    func action() ->  ActionCell
    func getLayout() -> CustomFlowLayout
}

protocol PresenterToInteractorListCharactersProtocol: class {
    var presenter: InteractorToPresenterListCharactersProtocol? { get set }
    var result: Result? { get }
    
    func getInitialCharacters()
    func isNeedUpdateCharacters()
    func changeLayoutAction() -> (title: String, customLayout: CustomLayout)
    func updateFavoriteCharacter(isFavorite: Bool, character: FavoriteCharacter?)
    func getTitleGridButton() -> String
    func updateImageInCharacters(id: Int, image: UIImage)
    
    func isVisibleChangeLayoutViewButton() -> Bool
    func action() ->  ActionCell
    func getLayout() -> CustomFlowLayout
}

protocol InteractorToPresenterListCharactersProtocol: class {
    func successResponse()
    func getCharactersFail(errorMessage: String)
}

protocol PresenterToViewListCharactersProtocol: class {
    func updateCollectionView()
    func getCharactersFail(errorMessage: String)
}

protocol PresenterToRouterListCharactersProtocol: class {
    static func createModule() -> UIViewController
    func pushToCharacterDetail(on view: PresenterToViewListCharactersProtocol, with character: Character)
}
