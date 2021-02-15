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
    func getCommicsImage()
}

protocol PresenterToInteracatorDetailCharacterProtocol: class {
    var presenter: InteractorToPresenterDetailCharacterProtocol? { get set }
    var character: Character? { get set }
    
    func fillDescription() -> String
    func fillImage()
    func getCommicsImage()
}

protocol InteractorToPresenterDetailCharacterProtocol: class {
    func updateWithImage(image: UIImage)
    func updateWithStringImage(stringImage: URL)
    func updateWithCommicImages()
}

protocol PresenterToViewDetailCharacterProtocol: class {
    func updateWithImage(image: UIImage)
    func updateWithStringImage(stringImage: URL)
    func updateWithCommicImages()
}

protocol PresenterToRouterDetailProtocol: class {
    static func createModule(withCharacter: Character) -> UIViewController
}
