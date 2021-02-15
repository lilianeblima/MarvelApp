//
//  CustomLayout.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

struct CustomLayoutCell {
    var action: ActionCell = .loading
    var customLayout: CustomFlowLayout = CustomFlowLayout(custom: .list)
    
    init(action: ActionCell, customLayout: CustomFlowLayout) {
        self.action = action
        self.customLayout = customLayout
    }
}
