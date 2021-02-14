//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit
import Kingfisher

protocol FavoriteActionProtocol: class {
    func buttonTapped(isFavorite: Bool, character: Character)
}

class CharacterCell: UICollectionViewCell, NibReusable {

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
        configureCell(name: character.name, isFavorite: character.isFavorite, imageString: character.imagePath, image: nil)
    }
    
    func configure(withFavoriteCharacter character: FavoriteCharacter) {
        configureCell(name: character.name, isFavorite: true, imageString: "", image: nil)
    }
    
    private func configureCell(name: String, isFavorite: Bool, imageString: String, image: UIImage?) {
        nameLabel.text = name
        let imageName = isFavorite ? "Favorite" : "NoFavorite"
        favoriteImage.image = UIImage(named: imageName)
        if let image = image {
            imageCharacter.image = image
        } else if let url = URL(string: imageString) {
            imageCharacter.kf.setImage(with: url)
        }
        
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        if let currentCharacter = currentCharacter {
            delegate?.buttonTapped(isFavorite: !currentCharacter.isFavorite, character: currentCharacter)
        }
    }

}
