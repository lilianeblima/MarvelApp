//
//  NibReusable.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit

protocol NibLoadName: class {
    static var nibName: String { get }
}

extension NibLoadName where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

protocol ReusableIdentifier: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableIdentifier where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibReusable: NibLoadName, ReusableIdentifier { }

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableIdentifier {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibReusable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? where T: ReusableIdentifier {
        let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T
        return cell
    }
}
