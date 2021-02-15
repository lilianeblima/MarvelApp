//
//  DetailCharacterPresenter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

class DetailCharacterPresenter: ViewToPresenterDetailCharacterProtocol {
    var view: PresenterToViewDetailCharacterProtocol?
    var router: PresenterToRouterDetailProtocol?
    var interactor: PresenterToInteracatorDetailCharacterProtocol?
    
    func fillDescription() -> String {
        interactor?.fillDescription() ?? Messages.noDescription
    }
    
    func fillImage() {
        interactor?.fillImage()
    }
    
    func navigationTitle() -> String {
        interactor?.character?.name ?? String()
    }
    
    func getCurrentCharacter() -> Character? {
        interactor?.character
    }
    
    func getSeriesAndComics() {
        interactor?.getSeriesAndComics()
    }
    
    func getImageNameToFavoriteIcon() -> String {
        interactor?.getImageNameToFavoriteIcon() ?? String()
    }
    
    func updateFavoriteCharacter() {
        interactor?.updateFavoriteCharacter()
    }
    
    
}

extension DetailCharacterPresenter: InteractorToPresenterDetailCharacterProtocol {
    func updateWithImage(image: UIImage) {
        view?.updateWithImage(image: image)
    }
    
    func updateWithStringImage(stringImage: URL) {
        view?.updateWithStringImage(stringImage: stringImage)
    }
    
    func updateComics(action: ActionCell, customLayout: CustomFlowLayout) {
        view?.updateComics(action: action, customLayout: customLayout)
    }

    func updateSeries(action: ActionCell, customLayout: CustomFlowLayout) {
        view?.updateSeries(action: action, customLayout: customLayout)
    }
    
    func updateFavoriteIcon() {
        view?.updateFavoriteIcon()
    }
    
    func showAlertError(message: String) {
        view?.showAlertError(message: message)
    }
    
}
