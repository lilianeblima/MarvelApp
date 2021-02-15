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
        if let description = interactor?.character?.description, description.isEmpty {
            return "Sem descrição"
        }
        return interactor?.character?.description ?? "Sem descrição"
    }
    
    func fillImage() -> UIImage {
        (interactor?.character?.image)!
    }

}

extension DetailCharacterPresenter: InteractorToPresenterDetailCharacterProtocol {
    
}
