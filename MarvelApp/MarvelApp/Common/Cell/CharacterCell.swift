//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 13/02/21.
//

import UIKit
import Kingfisher

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(character: Character) {
        nameLabel.text = character.name
        let imageName = character.isFavorite ? "Favorite" : "NoFavorite"
        favoriteImage.image = UIImage(named: imageName)
        
        if let url = URL(string: character.image) {
            imageCharacter.kf.setImage(with: url)
        }
    }
}
