//
//  Reusable.swift
//  wenovel
//
//  Created by Tbxark on 10/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol PLDataModelCellProtocol {
    associatedtype DataModelType
    
    func configureWithDataModel(_ dataModel: DataModelType)
}

protocol PLViewModelCellProtocol {
    associatedtype ViewModelType
    
    func configureWithViewModel(_ viewModel: ViewModelType)
}

protocol PLTableViewCellProtocol: class {
    static var defaultHeight: CGFloat { get }
}

protocol PLCollectionViewCellProtocol: class {
    static var defaultSize: CGSize { get }
}

class PLTableViewCell: UITableViewCell, Reusable {
}

extension UITableView {
    final func registerCell<T:UITableViewCell>(_ type: T.Type) where T: Reusable {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    final func registerNib<T:UITableViewCell>(_ type: T.Type) where T: Reusable {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    final func registerHeaderFooter<T:UITableViewHeaderFooterView>(_ type: T.Type) where T: Reusable {
        register(type, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T:UITableViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
    
    final func dequeueReusableHeaderFooter<T:UITableViewHeaderFooterView>(cellType: T.Type = T.self) -> T where T: Reusable {
        return dequeueReusableHeaderFooterView(withIdentifier: cellType.reuseIdentifier) as! T
    }
    
}


extension UICollectionView {
    func registerCell<T:UICollectionViewCell>(_ type: T.Type) where T: Reusable {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerNib<T:UICollectionViewCell>(_ type: T.Type) where T: Reusable {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerHeader<T:UICollectionReusableView>(_ type: T.Type) where T: Reusable {
        register(type, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.reuseIdentifier)
    }
    
    func registerFooter<T:UICollectionReusableView>(_ type: T.Type) where T: Reusable {
        register(type, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        return dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueSupplementaryView<T:UICollectionReusableView>(_ kind: String, indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
}
