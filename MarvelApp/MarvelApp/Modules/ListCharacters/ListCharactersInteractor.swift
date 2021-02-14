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
    private var favorites: [FavoriteCharacter] = []
    private let database = Database()
    typealias CompletionHandler = (_ success: Bool, _ errorMessage: String?) -> Void

    func getCharacters() {
        guard let url = RequestEndpoint.characters(customQuery: nil).url else {
            //TO DO: tratamento de erro
            return
        }
        favorites = database.getAllElements()
        Alamofire.request(url).response { response in
            if let data = response.data {
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: data)
                    self.result = decoder
                    self.updateFavorite()
                    self.presenter?.successResponse()
                } catch let error {
                    // Tratamento de erro
                    self.presenter?.getCharactersFail(errorMessage: "Errouu - Detalhes: \(error)")
                }
            } else {
                // Tratamento de erro
            }
        }
    }
    
    func updateFavorite() {
        for item in favorites  {
            if let index = self.result?.data.allCharacters.firstIndex(where: { $0.id == item.id }) {
                self.result?.data.allCharacters[index].isFavorite = true
                favorites.removeAll(where: { $0.id == item.id })
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
                    self.presenter?.successResponse()
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
        updateFavorite()
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
    
    // MARK: - FAvorite Action
    func updateFavoriteCharacter(isFavorite: Bool, character: FavoriteCharacter?) {
        selectedActionFavorite(withCharacter: character, isFavorite: isFavorite) { success, errorMessage  in
            if success, let index = self.result?.data.allCharacters.firstIndex(where: { $0.id == character?.id }) {
                self.result?.data.allCharacters[index].isFavorite = isFavorite
                // Ou atualizar só a celula?
                self.presenter?.successResponse()
            } else {
                // Error
            }
        }
    }
    
    func selectedActionFavorite(withCharacter: FavoriteCharacter?, isFavorite: Bool, completion: CompletionHandler) {
        if !isFavorite {
            removeCharacterFavorite(withId: withCharacter?.id ?? 0, completion: completion)
        } else if isFavorite, let favoriteCharacter = withCharacter {
            saveNewCharacterFavorite(withCharacter: favoriteCharacter, completion: completion)
        } else {
            completion(false, "Erro ao converter objeto")
        }
    }
    
    func saveNewCharacterFavorite(withCharacter:FavoriteCharacter, completion: CompletionHandler) {
        database.save(favoriteCharacter: withCharacter, completion: completion)
    }
    
    func removeCharacterFavorite(withId id: Int, completion: CompletionHandler) {
        database.remove(favoriteId: id, completion: completion)
    }
}
