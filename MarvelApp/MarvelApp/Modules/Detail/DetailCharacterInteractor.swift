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
    let database = Database()
    
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
    
    func getSeriesAndComics() {
        getComics()
        getSeries()
    }
        
    func getComics() {
        getExtras(url: RequestEndpoint.character(characterId: String(character?.id ?? 0), extra: "comics").url) { response in
            switch response {
            case .success(let result):
                self.character?.comics = result.data.results
                let action = self.action(message: String(), extras: result.data.results)
                self.presenter?.updateComics(action: action.action, customLayout: action.customLayout)
            case .error(let error):
                let customError = error as? ErrorResponse
                let action = self.action(message: customError?.localizedDescription ?? ErrorMessage.defaultMessage, extras: nil)
                self.presenter?.updateComics(action: action.action, customLayout: action.customLayout)
            }
        }
    }
    
    func getSeries() {
        getExtras(url: RequestEndpoint.character(characterId: String(character?.id ?? 0), extra: "series").url) { response in
            switch response {
            case .success(let result):
                self.character?.series = result.data.results
                let action = self.action(message: String(), extras: result.data.results)
                self.presenter?.updateSeries(action: action.action, customLayout: action.customLayout)
            case .error(let error):
                let customError = error as? ErrorResponse
                let action = self.action(message: customError?.localizedDescription ?? ErrorMessage.defaultMessage, extras: nil)
                self.presenter?.updateSeries(action: action.action, customLayout: action.customLayout)
            }
        }
    }
    
    func getExtras(url: URL?, completion: @escaping (Response<ResultExtras>) -> Void) {
        NetworkManager.request(url: url, completion: completion)
    }
    
    func action(message: String, extras: [ExtraPlus]?) -> CustomLayoutCell {
        if let extras = extras, !extras.isEmpty {
            return CustomLayoutCell(action: .showResult, customLayout: CustomFlowLayout(custom: .grid, direction: .horizontal, height: 190))
        } else if let extras = extras, extras.isEmpty {
            return CustomLayoutCell(action: .errorMessage(message: Messages.empty), customLayout: CustomFlowLayout(custom: .list, direction: .horizontal, height: 190))
        }
        return CustomLayoutCell(action: .errorMessage(message: message), customLayout: CustomFlowLayout(custom: .list, direction: .horizontal, height: 150))
    }
    
    func getImageNameToFavoriteIcon() -> String {
        return database.contains(withId: character?.id ?? 0) ? ImageNames.favoriteTabbarSelected : ImageNames.favoriteTabbar
    }
    
    func updateFavoriteCharacter() {
        if database.contains(withId: character?.id ?? 0) {
            database.remove(favoriteId: character?.id ?? 0) { success, _ in
                success ? self.presenter?.updateFavoriteIcon() : self.presenter?.showAlertError(message: AlertMessage.removeFavorite)            }
        } else if let favorite = character?.convertToFavorite() {
            database.save(favoriteCharacter: favorite) { success, _ in
                success ? self.presenter?.updateFavoriteIcon() : self.presenter?.showAlertError(message: AlertMessage.saveFavorite)
            }
        } else {
            self.presenter?.showAlertError(message: AlertMessage.defaultMessage)
        }
    }
    
}
