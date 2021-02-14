//
//  ListCharactersInteractor.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit
import Alamofire

class ListCharactersInteractor: PresenterToInteractorListCharactersProtocol {
    
    var presenter: InteractorToPresenterListCharactersProtocol?
    var result: Result?
    private var wating: Bool = false
    var currentLayoutCollection: CustomLayout = .grid

    func getCharacters() {
        guard let url = RequestEndpoint.characters(customQuery: nil).url else {
            //TO DO: tratamento de erro
            return
        }
        Alamofire.request(url).response { response in
            if let data = response.data {
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: data)
                    self.result = decoder
                    self.presenter?.getCharactersSuccess()
                } catch let error {
                    // Tratamento de erro
                    self.presenter?.getCharactersFail(errorMessage: "Errouu - Detalhes: \(error)")
                }
            } else {
                // Tratamento de erro
            }
        }
    }

    func updateCharacters() {
        guard let url = RequestEndpoint.characters(customQuery: getQuery()).url, !wating else {
            return
        }
        wating = true
        Alamofire.request(url).response { response in
            self.wating = false
            if let data = response.data {
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: data)
                    self.updateResult(newCharacters: decoder.data.allCharacters)
                    self.presenter?.getCharactersSuccess()
                } catch let error {
                    // Tratamento de erro
                    self.presenter?.getCharactersFail(errorMessage: "Errouu - Detalhes: \(error)")
                }
            } else {
                
            }
        }
    }
    
    func isNeedUpdateCharacters() {
        if let needUpdate = result?.existNextPagination, needUpdate {
            presenter?.needUpdateCharacters()
            updateCharacters()
        }
    }
    
    func updateResult(newCharacters: [Character]) {
        result?.data.newCharacters = newCharacters
        for character in newCharacters {
            result?.data.allCharacters.append(character)
        }
    }
    
    func getQuery() -> [String: String] {
        return ["offset": "\(result?.data.allCharacters.count ?? 0)"]
    }
    
    func getCustomLayout() -> (title: String, customLayout: CustomLayout) {
        var customLayout = CustomLayout.grid
        var buttonTitle = "Lista"
        if currentLayoutCollection == .grid {
            customLayout = CustomLayout.list
            buttonTitle = "Grid"
        }
        currentLayoutCollection = customLayout
        return(buttonTitle, customLayout)
    }
    
    // TODO: Remover
    func getCharacters(completion: @escaping (_ characters: [Character]?, _ errorMessage: String?) -> Void) {
        guard let url = RequestEndpoint.characters(customQuery: nil).url else {
            //TO DO: tratamento de erro
            return
        }
        Alamofire.request(url).response { response in
            if let data = response.data {
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: data)
                    completion(decoder.data.allCharacters, nil)
                } catch let error {
                    // Tratamento de erro
                    print(error)
                }
            } else {
                // Tratamento de erro
            }
        }
    }
}
