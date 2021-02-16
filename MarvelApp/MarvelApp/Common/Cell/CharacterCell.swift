//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit
import Kingfisher

@objc protocol FavoriteActionProtocol: class {
    func buttonTapped(isFavorite: Bool, character: FavoriteCharacter?)
    @objc optional func updateImage(id: Int, image: UIImage)
}

class CharacterCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: FavoriteActionProtocol?
    private var currentCharacter: Character?
    private var currentFavoriteCharacter: FavoriteCharacter?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(character: Character) {
        setupAutomaticScaleLabel()
        currentCharacter = character
        configureCell(name: character.name, isFavorite: character.isFavorite, imageString: character.imagePath, image: nil)
    }
    
    func configure(withFavoriteCharacter character: FavoriteCharacter) {
        currentFavoriteCharacter = character
        let image = UIImage(data: character.image as Data? ?? Data())
        configureCell(name: character.name, isFavorite: true, imageString: String(), image: image)
    }
    
    func configureExtras(item: ExtraPlus) {
        setupAutomaticScaleLabel()
        favoriteImage.isHidden = true
        favoriteButton.isEnabled = false
        nameLabel.text = item.title
        if let url = URL(string: "\(item.thumbnail.path).\(item.thumbnail.extension)") {
            imageCharacter.kf.setImage(with: url)
        }
    }
    
    private func setupAutomaticScaleLabel() {
        nameLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    private func configureCell(name: String, isFavorite: Bool, imageString: String, image: UIImage?) {
        nameLabel.text = name
        let imageName = isFavorite ? ImageNames.favoriteIcon : ImageNames.noFavoriteIcon
        favoriteImage.image = UIImage(named: imageName)
        if let image = image {
            imageCharacter.image = image
        } else if let url = URL(string: imageString) {
            imageCharacter.kf.setImage(with: url, completionHandler:  { useImage, _, _, _ in
                if let useImage = useImage {
                    self.currentCharacter?.image = useImage
                    self.delegate?.updateImage?(id: self.currentCharacter?.id ?? Int(), image: useImage)
                }
            })

        }
        
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        if let currentCharacter = currentCharacter {
            delegate?.buttonTapped(isFavorite: !currentCharacter.isFavorite, character: currentCharacter.convertToFavorite())
        } else if let currentFavoriteCharacter = currentFavoriteCharacter {
            delegate?.buttonTapped(isFavorite: false, character: currentFavoriteCharacter)
        }
    }

}
