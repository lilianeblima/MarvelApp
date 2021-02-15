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
    
    func getCommicsImage() {
        interactor?.getCommicsImage()
    }
}

extension DetailCharacterPresenter: InteractorToPresenterDetailCharacterProtocol {
    func updateWithImage(image: UIImage) {
        view?.updateWithImage(image: image)
    }
    
    func updateWithStringImage(stringImage: URL) {
        view?.updateWithStringImage(stringImage: stringImage)
    }
    
    func updateWithCommicImages() {
        view?.updateWithCommicImages()
    }

}
