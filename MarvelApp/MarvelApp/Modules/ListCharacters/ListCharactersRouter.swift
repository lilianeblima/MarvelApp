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
        let viewController = ListCharactersTableViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let presenter: ViewToPresenterListCharactersProtocol & InteractorToPresenterListCharactersProtocol = ListCharacterPresenter()
        let interactor: PresenterToInteractorListCharactersProtocol = ListCharactersInteractor()
        let router: PresenterToRouterListCharactersProtocol = ListCharactersRouter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ListCharactersRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ListCharactersInteractor()
        viewController.presenter?.interactor?.presenter = presenter
//        presenter.view = viewController
//        presenter.router = router
//        presenter.interactor = interactor
//        interactor.presenter = presenter
        
        return viewController
    }
    
//    viewController.presenter?.router = QuotesRouter()
//    viewController.presenter?.view = viewController
//    viewController.presenter?.interactor = QuotesInteractor()
//    viewController.presenter?.interactor?.presenter = presenter
}
