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
    func fillImage() -> UIImage
}

protocol PresenterToInteracatorDetailCharacterProtocol: class {
    var presenter: InteractorToPresenterDetailCharacterProtocol? { get set }
    var character: Character? { get set }
}

protocol InteractorToPresenterDetailCharacterProtocol: class {
    
}

protocol PresenterToViewDetailCharacterProtocol: class {
    
}

protocol PresenterToRouterDetailProtocol: class {
    static func createModule(withCharacter: Character) -> UIViewController
}
