//
//  ListTest.swift
//  MarvelAppTests
//
//  Created by Liliane Bezerra Lima on 17/02/21.
//

import XCTest
@testable import MarvelApp

class ListTest: XCTestCase {
    
    var presenter: ListCharacterPresenter?
    var interactor = ListInteractorMock()
    var view = UIStoryboard(name: "ListCharacters", bundle: nil).instantiateViewController(identifier: "ListCharactersViewController") as ListCharactersViewController
    
    override func setUp() {
        presenter = ListCharacterPresenter()
        presenter?.interactor = interactor
        interactor.presenter = presenter
        view.presenter = presenter
    }
    
    func testChangeLayout() {
        let result = presenter?.changeLayoutAction()
        XCTAssertEqual(result?.title, "Lista")
        XCTAssertEqual(result?.customLayout, CustomLayout.grid)
    }
    
    func testGetTitle() {
        XCTAssertEqual(presenter?.getTitleGridButton(), "Lista")
    }
    
    func testIsVisibleButton() {
        XCTAssertEqual(presenter?.isVisibleChangeLayoutViewButton(), false)
    }
    
    func testAction() {
        switch presenter?.action() {
        case .loading:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testLayout() {
        switch presenter?.getLayout().customType {
        case .list:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testInitialCharacters() {
        getInitialCharactersTest = false
        view.presenter?.getInitialCharacters()
        XCTAssertTrue(getInitialCharactersTest)
    }
    
    func testRefres() {
        isNeedUpdateCharactersTest = false
        view.refreshAction()
        XCTAssertTrue(isNeedUpdateCharactersTest)
    }
    
    func testUpdateFavoriteCharacter() {
        view.presenter?.updateFavoriteCharacter(isFavorite: false, character: FavoriteCharacter(name: "Personagem", image: nil, id: 0))
        
        XCTAssertEqual(favoriteResultsTest?.isFavorite, false)
        XCTAssertEqual(favoriteResultsTest?.character?.name, "Personagem")
        XCTAssertEqual(favoriteResultsTest?.character?.id, 0)
    }
    
    func testUpdateImage() {
        view.updateImage(id: 0, image: UIImage())
        
        XCTAssertEqual(updateImageInCharactersTest?.id, 0)
    }
}

var getInitialCharactersTest = false
var isNeedUpdateCharactersTest = false
var favoriteResultsTest: (isFavorite: Bool, character: FavoriteCharacter?)?
var updateImageInCharactersTest: (id: Int, image: UIImage)?

class ListInteractorMock: PresenterToInteractorListCharactersProtocol {
    var presenter: InteractorToPresenterListCharactersProtocol?
    
    var result: Result?
    
    func getInitialCharacters() {
        getInitialCharactersTest = true
    }
    
    func isNeedUpdateCharacters() {
        isNeedUpdateCharactersTest = true
    }
    
    func changeLayoutAction() -> (title: String, customLayout: CustomLayout) {
        return (title: "Lista", customLayout: CustomLayout.grid)
    }
    
    func updateFavoriteCharacter(isFavorite: Bool, character: FavoriteCharacter?) {
        favoriteResultsTest = (isFavorite: isFavorite, character: character)
    }
    
    func getTitleGridButton() -> String {
        return "Lista"
    }
    
    func updateImageInCharacters(id: Int, image: UIImage) {
        updateImageInCharactersTest = (id: id, image: image)
    }
    
    func isVisibleChangeLayoutViewButton() -> Bool {
        false
    }
    
    func action() -> ActionCell {
        ActionCell.loading
    }
    
    func getLayout() -> CustomFlowLayout {
        CustomFlowLayout(custom: .list)
    }
}
