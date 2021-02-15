//
//  DetailCharacterInteractor.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit
import Alamofire

class DetailCharacterInteractor: PresenterToInteracatorDetailCharacterProtocol {
    
    weak var presenter: InteractorToPresenterDetailCharacterProtocol?
    var character: Character?
    var result: ResultExtras?
    
    func fillDescription() -> String {
        if let description = character?.description, description.isEmpty {
            return Messages.noDescription
        }
        return character?.description ?? Messages.noDescription
    }
    
    func fillImage() {
        if let image = character?.image {
            presenter?.updateWithImage(image: image)
        } else if let imageString = character?.imagePath, let url = URL(string: imageString) {
            presenter?.updateWithStringImage(stringImage: url)
        }
    }
    
    func getCommicsImage() {
        
        if !(character?.comics?.isEmpty ?? false), let url = RequestEndpoint.character(characterId: String(character?.id ?? 0), extra: "comics").url {
            Alamofire.request(url).response { response in
                if let data = response.data {
                    do {
                        let decoder = try JSONDecoder().decode(ResultExtras.self, from: data)
                        self.result = decoder
                        self.character?.comics = decoder.data.results
                        print(decoder)
                        self.presenter?.updateWithCommicImages(action: self.action().action, customLayout: self.action().layout)
                    } catch let error {
                        print(error)
                        // Tratamento de erro
                    }
                } else {
                    // Tratamento de erro
                }
            }
        }
    }
    
    func action() -> (action: ActionCell, layout: CustomFlowLayout) {
        if let commics = character?.comics, !commics.isEmpty {
            return (action: .showResult, layout: CustomFlowLayout(custom: .grid, direction: .horizontal, height: 190))
        } else if let commics = character?.comics, !commics.isEmpty {
            return (action: .errorMessage(message: "Não tem commics"), layout: CustomFlowLayout(custom: .list, direction: .horizontal, height: 190))
        }
        return (action: .errorMessage(message: "Ops"), layout: CustomFlowLayout(custom: .list, direction: .horizontal, height: 150))
    }
}
