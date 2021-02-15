//
//  SeriesCollectionViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

protocol SeriesUpdate {
    func update(character: Character?, action: ActionCell, customLayout: CustomFlowLayout)
}

class SeriesCollectionViewController: UICollectionViewController, SeriesUpdate {
    func update(character: Character?, action: ActionCell, customLayout: CustomFlowLayout) {
        self.character = character
        self.action = action
        self.collectionView.collectionViewLayout =  customLayout
        collectionView.reloadData()
    }
    

    var character: Character?
    var action: ActionCell = .loading
    var isLoading: Bool {
        return character?.comics == nil ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(AlertCell.self)
        self.collectionView.register(CharacterCell.self)
        self.collectionView.register(LoadingCell.self)
        self.collectionView.collectionViewLayout =  CustomFlowLayout(custom: .list, direction: .horizontal, height: 190)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = character?.series?.count, count == 0 {
            return 1
        }
        return character?.series?.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        guard let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath), let item = character?.series?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configureExtras(item: item)
        return cell
    }

}
