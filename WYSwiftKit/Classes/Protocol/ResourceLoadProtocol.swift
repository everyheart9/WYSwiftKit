//
//  ResourceLoadProtocol.swift
//  GYHSConsumer
//
//  Created by apple on 2023/12/13.
//  Copyright © 2023 apple. All rights reserved.
//

import Foundation

public protocol ResourceLoadProtocol  {
    
}

extension ResourceLoadProtocol {
    public static func loadNib(frame: CGRect? = nil) -> Self {
        let nibView = Bundle.main.loadNibNamed(String(describing: Self.self), owner: Self.self)?.first as! Self
        if let view = nibView as? UIView {
            if let f = frame {
                view.frame = f
            } else {
                view.frame = UIScreen.main.bounds
            }
        }
        return nibView
    }
}
