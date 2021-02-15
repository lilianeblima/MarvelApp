//
//  ExtrasCollectionViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit


protocol ExtrasUpdate {
    func update(character: Character?, action: ActionCell, customLayout: CustomFlowLayout)
}

enum ActionCell {
    case showResult
    case loading
    case errorMessage(message: String)
}

class ExtrasCollectionViewController: UICollectionViewController, ExtrasUpdate {
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
        
        // Register cell classes
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
        return character?.comics?.count ?? 1
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
        guard let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath), let item = character?.comics?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configureExtras(item: item)
        return cell
    }
}

extension UICollectionView {
    func fillCellError(withMessage message: String, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AlertCell = self.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(withMessage: message)
        return cell
    }
    
    func fillCellLoading(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: LoadingCell = self.dequeueReusableCell(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.start()
        return cell
    }
}
