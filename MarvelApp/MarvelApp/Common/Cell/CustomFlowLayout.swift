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
        case .list:
            return 150
        }
    }
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    var itemHeight: CGFloat = 180
    var customType: CustomLayout = .grid
    var direction: UICollectionView.ScrollDirection = .vertical
    
    override init() {
        super.init()
        setupLayout()
    }
    
    init(custom: CustomLayout, direction: UICollectionView.ScrollDirection = .vertical, height: CGFloat? = nil) {
        self.customType = custom
        if let height = height {
            self.itemHeight = height
        } else {
            self.itemHeight = customType.getHeight()
        }
        
        self.direction = direction
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
        scrollDirection = direction
    }
    
    var itemWidth: CGFloat {
        switch customType {
        case .list:
            return collectionView?.frame.width ?? 0.0
        default:
            return (collectionView?.frame.width ?? 0.0) / 2 - 1
        }
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
