//
//  ResultExtras.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

struct ResultExtras: Codable {
    let code: Int
    var data: DataObjectExtras
}

struct DataObjectExtras: Codable {
    let total: Int
    var results: [ExtraPlus] = []
    
}
