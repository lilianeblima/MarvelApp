//
//  ListCharactersViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

class ListCharactersViewController: UIViewController {
    
    var presenter: ViewToPresenterListCharactersProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(AlertCell.self)
        self.collectionView.register(CharacterCell.self)
        self.collectionView.register(LoadingCell.self)
        collectionView.addSubview(refreshControl)
        self.presenter?.getInitialCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = Titles.characters
        updateRightButton()
        collectionView.reloadData()
    }
    
    @objc func refreshAction() {
        presenter?.isNeedUpdateCharacters()
    }
    
    @objc func changeListStyleAction() {
        guard let customLayout = presenter?.changeLayoutAction() else { return }
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = customLayout.title
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(CustomFlowLayout(custom: customLayout.customLayout), animated: true)
        }
    }
    
    func updateRightButton() {
        if let isVisibleRightButton = presenter?.isVisibleChangeLayoutViewButton(), isVisibleRightButton {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: presenter?.getTitleGridButton(), style: .done, target: self, action: #selector(changeListStyleAction))
        } else {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
        }
    }
}

extension ListCharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let action = presenter?.action() else {
            return UICollectionViewCell()
        }
        switch action {
        case .loading:
            return collectionView.fillCellLoading(indexPath: indexPath)
        case .showResult:
            return fillCellResult(indexPath: indexPath)
        case .errorMessage(let message):
            return collectionView.fillCellError(withMessage: message, indexPath: indexPath)
        }
    }
    
    private func fillCellResult(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath), let character = presenter?.getSelectedCharacter(index: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.configure(character: character)
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
        updateRightButton()
        guard let customLayout = presenter?.getLayout else { return }
        collectionView.collectionViewLayout = customLayout()
    }
    
    func getCharactersFail(errorMessage: String) {
        let alert = UIAlertController(title: AlertMessage.title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertMessage.ok, style: .default))
        self.present(alert, animated: true)
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
