//
//  ListCharactersViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

class ListCharactersViewController: UIViewController {
    
    @IBOutlet weak var rightButtonItem: UIBarButtonItem!
    var currentLayoutCollection: CustomLayout = .grid
    @IBAction func changeListStyleAction(_ sender: UIBarButtonItem) {

        var customLayout = CustomLayout.grid
        var buttonTitle = "Lista"
        if currentLayoutCollection == .grid {
            customLayout = CustomLayout.list
            buttonTitle = "Grid"
        }
        
        rightButtonItem.title = buttonTitle
        currentLayoutCollection = customLayout
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(CustomFlowLayout(custom: customLayout), animated: true)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: ViewToPresenterListCharactersProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = CustomFlowLayout(custom: .grid)
        collectionView.addSubview(refreshControl)
        self.presenter?.getInitialCharacters()
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func refreshAction() {
        presenter?.isNeedUpdateCharacters()

    }
}

extension ListCharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCell, let character = presenter?.getSelectedCharacter(index: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(character: character)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        if endScrolling >= (scrollView.contentSize.height) {
            presenter?.isNeedUpdateCharacters()
        }
    }
}

extension ListCharactersViewController: PresenterToViewListCharactersProtocol {
    func updateCollectionView() {
        self.collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
        refreshControl.endRefreshing()
        
    }
    
    func getCharactersFail(errorMessage: String) {
        print(errorMessage)
    }
    
    func showLoadViewCell() {
        // TODO: Mostrar footer de loading
    }
    
    
}
