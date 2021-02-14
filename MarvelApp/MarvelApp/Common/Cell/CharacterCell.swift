//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 13/02/21.
//

import UIKit
import Kingfisher
import RealmSwift

protocol FavoriteActionProtocol: class {
    func buttonTapped(isFavorite: Bool, character: Character)
}

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: FavoriteActionProtocol?
    var currentCharacter: Character?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(character: Character) {
        currentCharacter = character
        nameLabel.text = character.name
        let imageName = character.isFavorite ? "Favorite" : "NoFavorite"
        favoriteImage.image = UIImage(named: imageName)
        
        if let url = URL(string: character.imagePath) {
            imageCharacter.kf.setImage(with: url)
        }
    }
    @IBAction func favoriteAction(_ sender: UIButton) {
        if let currentCharacter = currentCharacter {
            delegate?.buttonTapped(isFavorite: !currentCharacter.isFavorite, character: currentCharacter)
        }
    }
}
