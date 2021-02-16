//
//  DetailTest.swift
//  MarvelAppTests
//
//  Created by Liliane Bezerra Lima on 16/02/21.
//

import XCTest
@testable import MarvelApp

class DetailViewTest: XCTestCase {

    var presenter = DetailPresenterMock()
    var interactor = DetailInteractorMock()
    var viewController = UIStoryboard(name: "ListCharacters", bundle: nil).instantiateViewController(identifier: "DetailCharacterTableViewController") as DetailCharacterTableViewController
    
    override func setUp() {
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
    }
    
    func testDescription() {
        XCTAssertEqual(viewController.presenter?.fillDescription(), "Descrição do personagem")
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(viewController.presenter?.navigationTitle(), "Personagem Selecionado")
    }
    
    func testfavoriteIcon() {
        XCTAssertEqual(viewController.presenter?.getImageNameToFavoriteIcon(), "favoriteIcon")
    }
    
    func testSelectedCharacter() {
        XCTAssertEqual(viewController.presenter?.getCurrentCharacter()?.name, "3-D Man")
        XCTAssertEqual(viewController.presenter?.getCurrentCharacter()?.id, 0)
        XCTAssertEqual(viewController.presenter?.getCurrentCharacter()?.imagePath, "imagePath.jpg")
    }
    
    func testSeriesAndComics() {
        updateComicsAndSeriesTest = false
        viewController.presenter?.getSeriesAndComics()
        XCTAssertTrue(updateComicsAndSeriesTest)
    }
    
    func testCharacter() {
        updateFavoriteCharacterTest = false
        viewController.presenter?.updateFavoriteCharacter()
        XCTAssertTrue(updateFavoriteCharacterTest)
    }
}

class DetailPresenterTest: XCTestCase {
    var presenter: ViewToPresenterDetailCharacterProtocol?
    var interactor = DetailInteractorMock()
    
    
    override func setUp() {
        presenter = DetailCharacterPresenter()
        presenter?.interactor = interactor
    }
    
    func testFillDescription() {
        XCTAssertEqual(presenter?.fillDescription(), "Sem descrição")
    }
    
    func testGetImageNameToFavoriteIcon() {
        XCTAssertEqual(presenter?.getImageNameToFavoriteIcon(), "Favorite")
    }
    
    func testFillImage() {
        presenterFillImageTest = false
        presenter?.fillImage()
        XCTAssertTrue(presenterFillImageTest)
    }
    
    func testGetSeriesAndComics() {
        presenterGetSeriesAndComicsTest = false
        presenter?.getSeriesAndComics()
        XCTAssertTrue(presenterGetSeriesAndComicsTest)
    }
    
    func testUpdateFavoriteCharacter() {
        presenterUpdateFavoriteCharacterTest = false
        presenter?.updateFavoriteCharacter()
        XCTAssertTrue(presenterUpdateFavoriteCharacterTest)
    }
}

class DetailInteractorTest: XCTestCase {
    var presenter = DetailPresenterMockInteractorResponseTest()
    var interactor: DetailCharacterInteractor?
    
    
    override func setUp() {
        interactor = DetailCharacterInteractor()
        interactor?.presenter = presenter
        let character = Character(name: "A.I.M", id: 0, imageObject: ImageObject(path: "pathImage", extension: "jpg"), description: "Descrição do personagem A.I.M", image: nil, comics: [ExtraPlus(id: 0, thumbnail: ImageObject(path: "pathImage", extension: "jpg"), title: "Comic 1"), ExtraPlus(id: 0, thumbnail: ImageObject(path: "pathImage", extension: "jpg"), title: "Comic 2")], series: [ExtraPlus(id: 0, thumbnail: ImageObject(path: "pathImage", extension: "jpg"), title: "Serie 1"), ExtraPlus(id: 0, thumbnail: ImageObject(path: "pathImage", extension: "jpg"), title: "Serie 2")])
        interactor?.character = character
    }
    
    func testDescription() {
        XCTAssertEqual(interactor?.fillDescription(), "Descrição do personagem A.I.M")
    }
    
    func testUpateFavorite() {
        interactor?.updateFavoriteCharacter()
        XCTAssertEqual("Ops", alertValue.title)
        XCTAssertEqual("Tivemos um problema, tente novamente mais tarde", alertValue.message)
    }
}


class DetailPresenterMockInteractorResponseTest: InteractorToPresenterDetailCharacterProtocol {
    func updateWithImage(image: UIImage) {
        
    }
    
    func updateWithStringImage(stringImage: URL) {
    }
    
    func updateComics(action: ActionCell, customLayout: CustomFlowLayout) {
        
    }
    
    func updateSeries(action: ActionCell, customLayout: CustomFlowLayout) {
        
    }
    
    func updateFavoriteIcon() {
        
    }
    
    func showAlertError(message: String) {
        alertValue = (title: "Ops", message: message)
    }
}


var presenterFillImageTest = false
var presenterGetSeriesAndComicsTest = false
var presenterUpdateFavoriteCharacterTest = false

class DetailInteractorMock: PresenterToInteracatorDetailCharacterProtocol {
    var presenter: InteractorToPresenterDetailCharacterProtocol?
    
    var character: Character?
    
    func fillDescription() -> String {
        return "Sem descrição"
    }
    
    func fillImage() {
        presenterFillImageTest = true
    }
    
    func getSeriesAndComics() {
        presenterGetSeriesAndComicsTest = true
    }
    
    func getImageNameToFavoriteIcon() -> String {
        return "Favorite"
    }
    
    func updateFavoriteCharacter() {
        presenterUpdateFavoriteCharacterTest = true
    }
    
}

var updateComicsAndSeriesTest = false
var updateFavoriteCharacterTest = false
var updateFillImage = false
class DetailPresenterMock: ViewToPresenterDetailCharacterProtocol {
    var view: PresenterToViewDetailCharacterProtocol?
    
    var router: PresenterToRouterDetailProtocol?
    
    var interactor: PresenterToInteracatorDetailCharacterProtocol?
    
    func fillDescription() -> String {
        return "Descrição do personagem"
    }
    
    func fillImage() {
        updateFillImage = true
    }
    
    func navigationTitle() -> String {
        return "Personagem Selecionado"
    }
    
    func getCurrentCharacter() -> Character? {
        let character = Character(name: "3-D Man", id: 0, imageObject: ImageObject(path: "imagePath", extension: "jpg"), description: nil, image: nil, comics: [], series: [])
        return character
    }
    
    func getSeriesAndComics() {
        updateComicsAndSeriesTest = true
    }
    
    func getImageNameToFavoriteIcon() -> String {
        return "favoriteIcon"
    }
    
    func updateFavoriteCharacter() {
        updateFavoriteCharacterTest = true
    }
    
    
}


