//
//  MainTabBarController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let favoriteVC = FavoriteRouter.createModule()
        let listCharactersVC = ListCharactersRouter.createModule()
        self.viewControllers = [listCharactersVC, favoriteVC]
        setup(index: 0, title: Titles.characters, imageName: ImageNames.charactersTabbar, imageSelectedName: ImageNames.charactersTabbarSelected)
        setup(index: 1, title: Titles.favorite, imageName: ImageNames.favoriteTabbar, imageSelectedName: ImageNames.favoriteTabbarSelected)
        
    }
    
    func setup(index: Int, title: String, imageName: String, imageSelectedName: String) {
        self.tabBar.items?[index].title = title
        self.tabBar.items?[index].image = UIImage(named: imageName)
        self.tabBar.items?[index].selectedImage = UIImage(named: imageSelectedName)
    }
}
