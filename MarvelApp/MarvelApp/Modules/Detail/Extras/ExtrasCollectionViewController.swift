//
//  ExtrasCollectionViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit


protocol ExtrasUpdate {
    var character: Character? { get set }
    func update(character: Character?)
}

class ExtrasCollectionViewController: UICollectionViewController, ExtrasUpdate {
    func update(character: Character?) {
        self.character = character
        collectionView.reloadData()
    }
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView.register(AlertCell.self)
        self.collectionView.register(CharacterCell.self)
        self.collectionView.collectionViewLayout =  CustomFlowLayout(custom: .grid, direction: .horizontal, height: 190)
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
        

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return character?.comics?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath), let item = character?.comics?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configureExtras(item: item)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
