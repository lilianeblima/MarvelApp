//
//  Constantes.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import Foundation

struct Titles {
    static let favorite = "Favoritos"
    static let characters = "Personagens"
}

struct ImageNames {
    static let favoriteTabbar = "tabbarFavorite"
    static let favoriteTabbarSelected = "tabbarFavoriteSelected"
    static let charactersTabbar = "tabbarCharacters"
    static let charactersTabbarSelected = "tabbarCharactersSelected"
    static let noFavoriteIcon = "NoFavorite"
    static let favoriteIcon = "Favorite"
    static let sadIcon = "sadIcon"
}

struct AlertMessage {
    static let defaultMessage = "Tivemos um problema, tente novamente mais tarde"
    static let title = "Ops"
    static let ok = "OK"
    static let emptyFavorite = "Ops! Você ainda não tem nenhum personagem favorito"
    static let saveFavorite = "Falha ao favoritar o personagem. Por favor tente novamente!"
    static let removeFavorite = "Falha ao tentar remver o personagem dos favoritos. Por favor tente novamente!"
}

struct Buttons {
    static let list = "Lista"
    static let grid = "Grid"
}

struct Messages {
    static let noDescription = "Sem descrição."
}

struct ErrorMessage {
    static let urlError = "URL incorreta"
    static let noConnection = "Sem conexão, por favor verificar a internet."
    static let defaultMessage = "Tivemos um problema, tente novamente mais tarde"
}
