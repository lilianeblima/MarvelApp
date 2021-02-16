//
//  FavoriteTest.swift
//  MarvelAppTests
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import XCTest
@testable import MarvelApp

class FavoriteTest: XCTestCase {
    
    var presenter: FavoritePresenter?
    var interactor = FavoriteMockInteracter()
    
    override func setUp() {
        presenter = FavoritePresenter()
        presenter?.interactor = interactor
        interactor.presenter = presenter
    }
    
    func testNumberRowInSectionSucess() {
        XCTAssertTrue(presenter?.numberOfRowsInSection() == 3)
        XCTAssertTrue(interactor.numberOfRowsInSection() == 3)
    }
    
    func testCollectionTypeSucess() {
        XCTAssertTrue(presenter?.collectionCellType() == CharacterCell.self)
        XCTAssertTrue(interactor.collectionCellType() == CharacterCell.self)
    }
    
    func testGetCustomLayoutSucess() {
        let interactorLayout = interactor.getCustomLayout() as? CustomFlowLayout
        XCTAssertNotNil(interactorLayout)
        XCTAssertTrue(interactorLayout?.itemHeight == 180)
        XCTAssertTrue(interactorLayout?.customType == CustomLayout.grid)
        XCTAssertTrue(interactorLayout?.direction == UICollectionView.ScrollDirection.vertical)
    }
    
    func testNumberOfRowsInSection() {
        XCTAssertEqual(interactor.numberOfRowsInSection(), presenter?.numberOfRowsInSection())
    }
    
    func testCollectionType() {
        XCTAssertTrue(interactor.collectionCellType() == presenter?.collectionCellType())
    }
    
    func testGetCustomLayout() {
        let interactorLayout = interactor.getCustomLayout() as? CustomFlowLayout
        let presenterLayout = presenter?.getCustomLayout() as? CustomFlowLayout
        XCTAssertNotNil(interactorLayout)
        XCTAssertNotNil(presenterLayout)
        
        XCTAssertTrue(interactorLayout?.itemHeight == presenterLayout?.itemHeight)
        XCTAssertTrue(interactorLayout?.customType == presenterLayout?.customType)
        XCTAssertTrue(interactorLayout?.direction == presenterLayout?.direction)
    }
    
    func testFavoriteSelected() {
        let favorite1 = FavoriteCharacter(name: "3-D Man", image: nil, id: 0)
        let favorite2 = FavoriteCharacter(name: "A.I.M", image: nil, id: 1)
        interactor.favoritesCharacters = [favorite1, favorite2]
        
        let selected = presenter?.getSelectedFavoriteCharacter(index: 1)
        XCTAssertEqual(selected?.name, "A.I.M")
        XCTAssertEqual(selected?.id, 1)
    }
    
    func testRefresh() {
        refreshInteractor = false
        presenter?.refresh()
        XCTAssertTrue(refreshInteractor)
    }
}

var refreshInteractor = false
class FavoriteMockInteracter: PresenterToInteracatorFavoriteProtocol {
    var presenter: InteractorToPresenterFavoriteProtocol?
    
    func numberOfRowsInSection() -> Int {
        return 3
    }
    
    func collectionCellType() -> UICollectionViewCell.Type {
        return CharacterCell.self
    }
    
    func getCustomLayout() -> UICollectionViewFlowLayout {
        return CustomFlowLayout(custom: .grid)
    }
    
    var favoritesCharacters: [FavoriteCharacter] = []
    
    func refresh() {
        refreshInteractor = true
        presenter?.refreshData()
    }
    
    func removeFavoriteIten(favorite: FavoriteCharacter?) {
        presenter?.refreshData()
    }
}
