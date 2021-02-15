//
//  ListCharactersViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

class ListCharactersViewController: UIViewController {
    
    var presenter: ViewToPresenterListCharactersProtocol?
    
    @IBOutlet weak var rightButtonItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = CustomFlowLayout(custom: .grid)
        collectionView.addSubview(refreshControl)
        self.presenter?.getInitialCharacters()
        let list = ListCharactersInteractor()
//        list.teste()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.checkFavoriteUpdate()
        self.navigationController?.navigationBar.topItem?.title = Titles.characters
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: presenter?.getTitleGridButton(), style: .done, target: self, action: #selector(changeListStyleAction))
    }
    
    @objc func refreshAction() {
        presenter?.isNeedUpdateCharacters()
    }
    
    @objc func changeListStyleAction() {
        guard let customLayout = presenter?.getCustomLayout() else { return }
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = customLayout.title
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(CustomFlowLayout(custom: customLayout.customLayout), animated: true)
        }
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
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let character = presenter?.getSelectedCharacter(index: indexPath.row) {
            presenter?.pushCharacterDetail(character: character)
        }
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

extension ListCharactersViewController: FavoriteActionProtocol {
    func buttonTapped(isFavorite: Bool, character: FavoriteCharacter?) {
        presenter?.updateFavoriteCharacter(isFavorite: isFavorite, character: character)
    }
    
    func updateImage(id: Int, image: UIImage) {
        presenter?.updateImageInCharacters(id: id, image: image)
    }
}
