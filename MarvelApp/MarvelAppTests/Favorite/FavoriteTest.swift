//
//  FavoriteTest.swift
//  MarvelAppTests
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import XCTest
@testable import MarvelApp

class FavoriteTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    var presenter: FavoritePresenter?
    var viewController = UIStoryboard(name: "Favorite", bundle: nil).instantiateViewController(identifier: "FavoriteViewController") as? FavoriteViewController
    var interactor = FavoriteMockInteracter()
    var view: FavoriteViewController?
    
    override func setUp() {
        
        let navigation = UINavigationController(rootViewController: viewController!)
        
        presenter = FavoritePresenter()
        presenter?.interactor = interactor
        presenter?.view = navigation.viewControllers.first as? FavoriteViewController
        view = navigation.viewControllers.first as? FavoriteViewController
    }
    
    func testNumberRowInSectionSucess() {
        XCTAssertTrue(presenter?.numberOfRowsInSection() == 3)
    }
    
    func testCollectionTypeSucess() {
        XCTAssertTrue(presenter?.collectionCellType() == CharacterCell.self)
    }
    
    func testGetCustomLayoutSucess() {
        let interactorLayout = interactor.getCustomLayout() as? CustomFlowLayout
        XCTAssertNotNil(interactorLayout)
        XCTAssertTrue(interactorLayout?.itemHeight == 180)
        XCTAssertTrue(interactorLayout?.customType == CustomLayout.grid)
        XCTAssertTrue(interactorLayout?.direction == UICollectionView.ScrollDirection.vertical)
    }
    
    // Test connection Interactor/Presenter
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

}

class FavoriteMockView: PresenterToViewFavoriteProtocol {
    func refresh() {
        
    }
    
    func showAlert(withTitle: String, andMessage: String) {
        
    }
}

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
        
    }
    
    func removeFavoriteIten(favorite: FavoriteCharacter?) {
        
    }
    
    
}
