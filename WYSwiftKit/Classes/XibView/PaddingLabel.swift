//
//  PaddingLabel.swift
//  WYSwiftKit
//
//  Created by apple on 2024/5/22.
//

import UIKit

/// Failed to render and update auto layout status for UIView (i5M-Pr-FkT): dlopen(GYCompany.app, Oxooo.. file), "GYCompany.app' (mach-o file. out is an incompatible architecture (have 'x86 _ 64， need 'arm64"))
@IBDesignable
class PaddingLabel: UILabel {

    private var padding = UIEdgeInsets.zero
    
    @IBInspectable
    var paddingTop: CGFloat {
        
        get {
            return padding.top }
        set {
            padding.top = newValue }
    }
    
    @IBInspectable
    var paddingLeft: CGFloat {
        
        get {
            return padding.left }
        set {
            padding.left = newValue }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        
        get {
            return padding.bottom }
        set {
            padding.bottom = newValue }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        
        get {
            return padding.right }
        set {
            padding.right = newValue }
    }
    
    
    //重新绘制文本
    override func drawText(in rect: CGRect) {
        
        super.drawText(in: rect.inset(by: padding))
    }
    
    //重新text文字框大小
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let insets = self.padding
        var rect = super.textRect(forBounds:bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }

}
