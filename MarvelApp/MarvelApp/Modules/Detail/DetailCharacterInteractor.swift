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
                        self.presenter?.updateWithCommicImages()
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
    
}
