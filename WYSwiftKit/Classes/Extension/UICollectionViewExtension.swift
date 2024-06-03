//
//  UICollectionViewExtension.swift
//  WYSwiftKit
//
//  Created by apple on 2023/12/16.
//  Copyright © 2023 apple. All rights reserved.
//

import Foundation
import UIKit

public struct SupplementKind {
    var rowValue: String
    static let header = SupplementKind.init(rowValue: UICollectionView.elementKindSectionHeader)
    static let footer = SupplementKind.init(rowValue: UICollectionView.elementKindSectionFooter)
}

public extension UICollectionView {
    private func identifier<T>(cellClass: T.Type) -> String {
        String(describing: cellClass)
    }
    
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: identifier(cellClass: cellClass))
    }
    
    func nibRegister<T: UICollectionViewCell>(cellClass: T.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: identifier(cellClass: cellClass), bundle: bundle), forCellWithReuseIdentifier: identifier(cellClass: cellClass))
    }
    
    func nibRegisterSupplementaryView<T: UICollectionReusableView>(cellClass: T.Type, kind: SupplementKind, bundle: Bundle? = nil) {
        register(UINib.init(nibName: identifier(cellClass: cellClass), bundle: bundle), forSupplementaryViewOfKind: kind.rowValue, withReuseIdentifier: identifier(cellClass: cellClass))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: identifier(cellClass: cellClass), for: indexPath) as? T
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind: SupplementKind, cellClass: T.Type, indexPath: IndexPath) -> T? {
        dequeueReusableSupplementaryView(ofKind: kind.rowValue, withReuseIdentifier: identifier(cellClass: cellClass), for: indexPath) as? T
    }
}
