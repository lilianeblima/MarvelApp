//
//  FavoriteViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: ViewToPresenterFavoriteProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AlertCell.self)
        collectionView.register(CharacterCell.self)
        collectionView.collectionViewLayout = presenter?.getCustomLayout() ?? CustomFlowLayout(custom: .grid)
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let type = presenter?.collectionCellType, type() == AlertCell.self, let cell: AlertCell = collectionView.dequeueReusableCell(for: indexPath) {
            cell.configure()
            return cell
        } else if  let type = presenter?.collectionCellType, type() == CharacterCell.self, let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath), let favoriteCharacter = presenter?.getSelectedFavoriteCharacter(index: indexPath.row) {
            cell.configure(withFavoriteCharacter: favoriteCharacter)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    
}

extension FavoriteViewController: PresenterToViewFavoriteProtocol {
    
}
