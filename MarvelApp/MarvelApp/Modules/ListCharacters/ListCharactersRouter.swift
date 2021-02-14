//
//  ListCharactersRouter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 13/02/21.
//

import UIKit
import Foundation

class ListCharactersRouter: PresenterToRouterListCharactersProtocol {
    
    static func createModule() -> UIViewController {
        
        let viewController = UIStoryboard(name: "ListCharacters", bundle: nil).instantiateViewController(identifier: "ListCharactersViewController") as ListCharactersViewController

        
        let presenter: ViewToPresenterListCharactersProtocol & InteractorToPresenterListCharactersProtocol = ListCharacterPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = ListCharactersRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ListCharactersInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
}
