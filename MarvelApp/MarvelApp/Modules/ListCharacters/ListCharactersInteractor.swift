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
    private let database = Database()
    private var favorites: [FavoriteCharacter] {
        return database.getAllElements()
    }
    
    typealias CompletionHandler = (_ success: Bool, _ errorMessage: String?) -> Void
    
    var viewLayout: CustomLayoutCell = CustomLayoutCell(action: .loading, customLayout: CustomFlowLayout(custom: .list))
    


    // MARK: - Resquest Characters
    func get(url: URL?, completion: @escaping (Response<Result>) -> Void) {
        NetworkManager.request(url: url, completion: completion)
    }

    func getCharacters(url: URL?) {
        get(url: url) { response in
            switch response {
            case .success(let responseValue):
                self.result = responseValue
                self.updateFavoriteCharacters()
                self.saveToWidget()
                self.updateLayout(newLayout: self.successAction())
                self.presenter?.successResponse()
            case .error(let error):
                let customError = error as? ErrorResponse
                self.updateLayout(newLayout: self.errorAction(message: customError?.localizedDescription ?? ErrorMessage.defaultMessage))
                self.presenter?.successResponse()
            }
        }
    }
    
    func getInitialCharacters() {
        updateLayout(newLayout: initialAction())
        self.presenter?.successResponse()
        getCharacters(url: RequestEndpoint.characters(customQuery: nil).url)
    }
    
    func getNewCharacters() {
        guard !wating else {
            return
        }
        wating = true
        get(url: RequestEndpoint.characters(customQuery: getQuery()).url) { response in
            self.wating = false
            switch response {
            case .success(let resultValue):
                self.updateResult(newCharacters: resultValue.data.allCharacters)
                self.presenter?.successResponse()
            case .error(let error):
                let customError = error as? ErrorResponse
                self.presenter?.getCharactersFail(errorMessage: customError?.localizedDescription ?? ErrorMessage.defaultMessage)
            }
        }
    }

    func updateCharacters() {
        getNewCharacters()
    }

    func isNeedUpdateCharacters() {
        if let needUpdate = result?.existNextPagination, needUpdate {
            updateCharacters()
        }
    }
    
    func updateResult(newCharacters: [Character]) {
        result?.data.newCharacters = newCharacters
        for character in newCharacters {
            result?.data.allCharacters.append(character)
        }
        updateFavoriteCharacters()
    }
    
    func getQuery() -> [String: String] {
        return ["offset": "\(result?.data.allCharacters.count ?? 0)"]
    }
    
    func updateLayout(newLayout: CustomLayoutCell) {
        viewLayout = newLayout
    }
    
    // MARK: - Update Layout
    func changeLayoutAction() -> (title: String, customLayout: CustomLayout) {
        var customLayout = CustomLayout.grid
        var buttonTitle = Buttons.list
        if viewLayout.customLayout.customType == .grid {
            customLayout = CustomLayout.list
            buttonTitle = Buttons.grid
        }
        viewLayout.customLayout.customType = customLayout
        return(buttonTitle, customLayout)
    }
    
    func getLayout() -> CustomFlowLayout {
        return viewLayout.customLayout
    }
    
    func isVisibleChangeLayoutViewButton() -> Bool {
        switch viewLayout.action {
        case .showResult:
            return true
        default:
            return false
        }
    }
    
    func action() -> ActionCell {
        viewLayout.action
    }
    
    func initialAction() -> CustomLayoutCell {
        return CustomLayoutCell(action: .loading, customLayout: CustomFlowLayout(custom: .list))
    }
    
    func successAction() -> CustomLayoutCell {
        return CustomLayoutCell(action: .showResult, customLayout: CustomFlowLayout(custom: .grid))
    }
    
    func errorAction(message: String) -> CustomLayoutCell {
        return CustomLayoutCell(action: .errorMessage(message: message), customLayout: CustomFlowLayout(custom: .list))
    }
    
    
    func updateImageInCharacters(id: Int, image: UIImage) {
        if let index = result?.data.allCharacters.firstIndex(where: { $0.id == id }) {
            result?.data.allCharacters[index].image = image
        }
        self.saveImageWidget()

    }
    
    // MARK: - Favorite Action
    func updateFavoriteCharacter(isFavorite: Bool, character: FavoriteCharacter?) {
        let isFavortieCharacter = !database.contains(withId: character?.id ?? 0)
        selectedActionFavorite(withCharacter: character, isFavorite: isFavortieCharacter) { success, errorMessage  in
            if success, let index = self.result?.data.allCharacters.firstIndex(where: { $0.id == character?.id }) {
                self.result?.data.allCharacters[index].isFavorite = isFavortieCharacter
                self.presenter?.successResponse()
            } else {
                self.presenter?.getCharactersFail(errorMessage: errorMessage ?? ErrorMessage.defaultMessage)
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
    
    func updateFavoriteCharacters() {
        for item in favorites  {
            if let index = self.result?.data.allCharacters.firstIndex(where: { $0.id == item.id }) {
                self.result?.data.allCharacters[index].isFavorite = true
            }
        }
    }
    
    func getTitleGridButton() -> String {
        return viewLayout.customLayout.customType == .grid ? Buttons.list : Buttons.grid
    }
    
    // MARK: - Widget
    func saveToWidget() {
        let sharedDefaults = UserDefaults(suiteName: SharedUserDefaults.suitName)
        if let characters = result?.data.allCharacters {
            let selecetdCharacters = characters[0..<3]
            for (index, iten) in selecetdCharacters.enumerated() {
                sharedDefaults?.setValue(iten.name, forKey: "name\(index)")
                sharedDefaults?.setValue(iten.id, forKey: "id\(index)")
                sharedDefaults?.setValue(iten.description, forKey: "description\(index)")
            }
        }
    }
    
    func saveImageWidget() {
        let sharedDefaults = UserDefaults(suiteName: SharedUserDefaults.suitName)
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
