//
//  ListCharactersInteractor.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit
import Alamofire


class ListCharactersInteractor: PresenterToInteractorListCharactersProtocol {
    
    weak var presenter: InteractorToPresenterListCharactersProtocol?
    var result: Result?
    private var wating: Bool = false
    var currentLayoutCollection: CustomLayout = .grid
    private var favorites: [FavoriteCharacter] = []
    private let database = Database()
    typealias CompletionHandler = (_ success: Bool, _ errorMessage: String?) -> Void

    func get(url: URL?, completion: @escaping (Response<Result>) -> Void) {
        NetworkManager.request(url: url, completion: completion)
    }
    
    func getResult(url: URL?) {
        get(url: url) { response in
            switch response {
            case .success(let responseValue):
                self.result = responseValue
                self.updateFavorite()
                self.presenter?.successResponse()
            case .error(let error):
                let customError = error as? ErrorResponse
                print(customError?.localizedDescription)
//                let action = self.action(message: customError?.localizedDescription ?? ErrorMessage.defaultMessage, extras: nil)
//                self.presenter?.updateComics(action: action.action, customLayout: action.customLayout)
            }
        }
    }
    
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
                    self.saveToWidget()
                    self.presenter?.successResponse()
                } catch {
                    // Tratamento de erro
                    self.presenter?.getCharactersFail(errorMessage: AlertMessage.defaultMessage)
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
                    self.presenter?.getCharactersFail(errorMessage: AlertMessage.defaultMessage)
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
        var buttonTitle = Buttons.list
        if currentLayoutCollection == .grid {
            customLayout = CustomLayout.list
            buttonTitle = Buttons.grid
        }
        currentLayoutCollection = customLayout
        return(buttonTitle, customLayout)
    }
    
    func updateImageInCharacters(id: Int, image: UIImage) {
        if let index = result?.data.allCharacters.firstIndex(where: { $0.id == id }) {
            result?.data.allCharacters[index].image = image
        }
        self.saveImageWidget()

    }
    
    // MARK: - Favorite Action
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
            completion(false, AlertMessage.defaultMessage)
        }
    }
    
    func saveNewCharacterFavorite(withCharacter:FavoriteCharacter, completion: CompletionHandler) {
        database.save(favoriteCharacter: withCharacter, completion: completion)
    }
    
    func removeCharacterFavorite(withId id: Int, completion: CompletionHandler) {
        database.remove(favoriteId: id, completion: completion)
    }
    
    func getTitleGridButton() -> String {
        return currentLayoutCollection == .grid ? Buttons.list : Buttons.grid
    }
    
    func saveToWidget() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.MarvelApp")
        if let characters = result?.data.allCharacters {
            let selecetdCharacters = characters[0..<3]
            for (index, iten) in selecetdCharacters.enumerated() {
                sharedDefaults?.setValue(iten.name, forKey: "name\(index)")
            }
        }
    }
    
    func saveImageWidget() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.MarvelApp")
        if let characters = result?.data.allCharacters {
            let selecetdCharacters = characters[0..<3]
            for (index, iten) in selecetdCharacters.enumerated() {
                if let image = iten.image?.toData() {
                    sharedDefaults?.setValue(image, forKey: "image\(index)")
                }
            }
        }
    }
}
