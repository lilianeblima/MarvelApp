//
//  FavoriteInteractorTest.swift
//  MarvelAppTests
//
//  Created by Liliane Bezerra Lima on 16/02/21.
//

import XCTest
@testable import MarvelApp

class FavoriteInteractorTest: XCTestCase {
    var presenter = FavoriteMockPresenter()
    var interactor: FavoriteInteractor?
    
    override func setUp() {
        interactor = FavoriteInteractor()
        interactor?.presenter = presenter
    }
    
    func testRefresh() {
        refreshPresenter = false
        interactor?.refresh()
        XCTAssertTrue(refreshPresenter)
    }
    
    func testRemoveFailDatabase() {
        let favorite = FavoriteCharacter(name: "A.I.M", image: nil, id: 0)
        interactor?.removeFavoriteIten(favorite: favorite)
        XCTAssertEqual("Ops", alertValue.title)
        XCTAssertEqual("Não existe o objeto salvo", alertValue.message)
    }
    
    func testRemoveSuccessDatabase() {
        let favorite = FavoriteCharacter(name: "A.I.M", image: nil, id: 0)
        let interactorMock = FavoriteMockInteracter()
        interactorMock.presenter = presenter
        refreshPresenter = false
        
        interactorMock.removeFavoriteIten(favorite: favorite)
        XCTAssertTrue(refreshPresenter)
    }
    
}

var refreshPresenter = false
var alertValue: (title: String, message: String) = (title: String(), message: String())
class FavoriteMockPresenter: InteractorToPresenterFavoriteProtocol {
    func refreshData() {
        refreshPresenter = true
    }
    
    func showAlert(withTitle: String, andMessage: String) {
        alertValue = (title: withTitle, message: andMessage)
    }
}
