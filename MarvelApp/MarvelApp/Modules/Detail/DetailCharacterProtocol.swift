//
//  DetailCharacterProtocol.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

protocol ViewToPresenterDetailCharacterProtocol: class {
    var view: PresenterToViewDetailCharacterProtocol?  { get set }
    var router: PresenterToRouterDetailProtocol?  { get set }
    var interactor: PresenterToInteracatorDetailCharacterProtocol?  { get set }
    
    func fillDescription() -> String
    func fillImage()
    func navigationTitle() -> String
    func getCurrentCharacter() -> Character?
    func getSeriesAndComics()
    
    func getImageNameToFavoriteIcon() -> String
    func updateFavoriteCharacter()
}

protocol PresenterToInteracatorDetailCharacterProtocol: class {
    var presenter: InteractorToPresenterDetailCharacterProtocol? { get set }
    var character: Character? { get set }
    
    func fillDescription() -> String
    func fillImage()
    func getSeriesAndComics()
    func getImageNameToFavoriteIcon() -> String
    func updateFavoriteCharacter()
}

protocol InteractorToPresenterDetailCharacterProtocol: class {
    func updateWithImage(image: UIImage)
    func updateWithStringImage(stringImage: URL)
    func updateComics(action: ActionCell, customLayout: CustomFlowLayout)
    func updateSeries(action: ActionCell, customLayout: CustomFlowLayout)
    func updateFavoriteIcon()
    func showAlertError(message: String)
}

protocol PresenterToViewDetailCharacterProtocol: class {
    func updateWithImage(image: UIImage)
    func updateWithStringImage(stringImage: URL)
    func updateComics(action: ActionCell, customLayout: CustomFlowLayout)
    func updateSeries(action: ActionCell, customLayout: CustomFlowLayout)
    func updateFavoriteIcon()
    func showAlertError(message: String)
}

protocol PresenterToRouterDetailProtocol: class {
    static func createModule(withCharacter: Character) -> UIViewController
}
