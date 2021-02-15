//
//  LoadingCell.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

class LoadingCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func start() {
        loadingActivityIndicator.startAnimating()
    }
    
    func finish() {
        loadingActivityIndicator.startAnimating()
    }

}
