//
//  CustomFlowLayout.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 13/02/21.
//

import UIKit

enum CustomLayout {
    case list
    case grid
    
    func getHeight() -> CGFloat {
        switch self {
        case .grid:
            return 180
        default:
            return 150
        }
    }
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 180
    private var customType: CustomLayout = .grid
    
    override init() {
        super.init()
        setupLayout()
    }
    
    init(custom: CustomLayout) {
        self.customType = custom
        self.itemHeight = customType.getHeight()
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    var itemWidth: CGFloat {
        if customType == .grid {
            return (collectionView?.frame.width ?? 0.0) / 2 - 1
        }
        return collectionView?.frame.width ?? 0.0
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth, height: itemHeight)
            
        }
        get {
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView?.contentOffset ?? CGPoint(x: 0, y: 0)
    }
}

