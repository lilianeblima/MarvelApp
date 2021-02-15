//
//  DetailCharacterRouter.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

class DetailCharacterRouter: PresenterToRouterDetailProtocol {
    
    static func createModule(withCharacter: Character) -> UIViewController {
        let viewController = UIStoryboard(name: "ListCharacters", bundle: nil).instantiateViewController(identifier: "DetailCharacterTableViewController") as DetailCharacterTableViewController
        
        let presenter: ViewToPresenterDetailCharacterProtocol & InteractorToPresenterDetailCharacterProtocol = DetailCharacterPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = DetailCharacterRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailCharacterInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter?.interactor?.character = withCharacter
        
        return viewController
    }
}
