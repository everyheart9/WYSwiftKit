//
//  UITableViewExtension.swift
//  WYSwiftKit
//
//  Created by apple on 2022/4/26.
//  Copyright © 2022 apple. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    private func identifier<T>(cellClass: T.Type) -> String {
        String(describing: cellClass)
    }

    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: identifier(cellClass: cellClass))
    }
    
    func nibRegister<T>(cellClass: T.Type, bundle: Bundle? = nil) {
        register(UINib.init(nibName: identifier(cellClass: cellClass), bundle: bundle), forCellReuseIdentifier: identifier(cellClass: cellClass))
    }
    
    func nibHeaderFooterRegister<T>(cellClass: T.Type, bundle: Bundle? = nil) {
        register(UINib.init(nibName: identifier(cellClass: cellClass), bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier(cellClass: cellClass))
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: identifier(cellClass: cellClass), for: indexPath) as? T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(cellClass: T.Type) -> T? {
        dequeueReusableHeaderFooterView(withIdentifier: identifier(cellClass: cellClass)) as? T
    }
}
