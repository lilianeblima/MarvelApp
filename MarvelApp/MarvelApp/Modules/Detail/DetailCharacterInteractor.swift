//
//  DetailCharacterInteractor.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import Foundation

class DetailCharacterInteractor: PresenterToInteracatorDetailCharacterProtocol {
    weak var presenter: InteractorToPresenterDetailCharacterProtocol?
    var character: Character?
}
