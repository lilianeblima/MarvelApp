//
//  FavoriteRouter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

class FavoriteRouter: PresenterToRouterFavoriteProtocol {
    
    static func createModule() -> UIViewController {
        let viewController = UIStoryboard(name: "Favorite", bundle: nil).instantiateViewController(identifier: "FavoriteViewController") as FavoriteViewController
        let presenter: ViewToPresenterFavoriteProtocol & InteractorToPresenterFavoriteProtocol = FavoritePresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = FavoriteRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FavoriteInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }

}
