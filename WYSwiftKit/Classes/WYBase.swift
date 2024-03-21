//
//  WYBase.swift
//  WYSwiftKit
//
//  Created by apple on 2024/3/21.
//

import Foundation

public struct WY<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol WYCompatible {}
public extension WYCompatible {
    static var gy: WY<Self>.Type {
        get { WY.self }
        set {}
    }
    
    var gy: WY<Self> {
        get { WY(self) }
        set {}
    }
}

extension String: WYCompatible { }
extension NSString: WYCompatible { }
extension NSAttributedString: WYCompatible { }
extension Dictionary: WYCompatible { }
extension Data: WYCompatible { }
extension UIControl: WYCompatible { }


//MARK: 适用于String, NSString, NSMutableString
public extension WY where Base: ExpressibleByStringLiteral {
    var urlEscaped: String {
        (base as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        Data((base as! String).utf8)
    }
}


//MARK: 适用于Array, NSArray, NSMutableArray
public extension WY where Base: ExpressibleByArrayLiteral {
    
}


//MARK: 适用于Dictionary, NSDictionary, NSMutableDictionary
public extension WY where Base: ExpressibleByDictionaryLiteral {
    
}



//MARK: 适用于Data
public extension WY where Base == Data {
    var json: String? {
        String(data: base, encoding: .utf8)
    }
}


//MARK: 适用于Button
public extension WY where Base: UIControl {
    
    func controlTimeOut() {
        base.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.base.isEnabled = true
        }
    }

}
