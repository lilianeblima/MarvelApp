//
//  AlertCell.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

class AlertCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        infoLabel.text = AlertMessage.emptyFavorite
        iconImage.image = UIImage(named: ImageNames.sadIcon)
    }
    
    func configure(withMessage message: String) {
        infoLabel.text = message
        iconImage.image = UIImage(named: ImageNames.sadIcon)
    }

}
