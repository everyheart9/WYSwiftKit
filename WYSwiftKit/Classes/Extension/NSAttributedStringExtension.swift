//
//  NSAttributedStringExtension.swift
//  WYSwiftKit
//
//  Created by apple on 2024/3/12.
//  Copyright © 2024 apple. All rights reserved.
//

import Foundation

public extension NSMutableAttributedString {
    /// 属性字符串拼接字符串
    func gy_appendString(_ str: String, _ attrs: Dictionary<NSAttributedString.Key, Any> = [:]) -> Self {
        let att = NSAttributedString.init(string: str, attributes: attrs)
        return self.gy_appendAttributedString(att)
    }
    
    /// 属性字符串拼接属性字符串
    func gy_appendAttributedString(_ attrsStr: NSAttributedString) -> Self {
        self.append(attrsStr)
        return self
    }
    
    /// 属性字符串根据某个字符串修改属性
    func gy_modifyAttributedString(_ str: String, _ attrs: Dictionary<NSAttributedString.Key, Any> = [:]) -> Self {
        
        let range = (self.string as NSString).range(of: str)
        if (range.location != NSNotFound && range.length > 0) {
            self.setAttributes(attrs, range: range)
        }
        return self
    }

    /// 给某个属性字符串增加属性
    func gy_addAttributed(_ attrs: Dictionary<NSAttributedString.Key, Any> = [:], range: NSRange) -> Self {
        self.addAttributes(attrs, range: range)
        return self
    }

    /// 通过图片和字体设置图片
    func gy_addImageAttributedAndFont(image: UIImage, font: UIFont) -> Self {
        
        let attachment = NSTextAttachment()
        attachment.image = image
        let imageSize = image.size
        let imageHeight = font.pointSize
        let imageWidth = imageSize.width / imageSize.height * imageHeight
        let paddingTop = (font.lineHeight - font.pointSize) * 0.5
        attachment.bounds = CGRectMake(0, -paddingTop, imageWidth, imageHeight)
        let imageAtt = NSAttributedString.init(attachment: attachment)
        
        return self.gy_appendAttributedString(imageAtt)
    }
    
    
    
    //MARK: - 直接设置属性
    
    func font(_ font: UIFont) -> Self {
        addAttributes([NSAttributedString.Key.font: font], range: NSMakeRange(0, self.length))
        return self
    }
    
    func color(_ color: UIColor) -> Self {
        addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSMakeRange(0, self.length))
        return self
    }
    
    func bgColor(_ color: UIColor) -> Self {
        addAttributes([NSAttributedString.Key.backgroundColor: color], range: NSMakeRange(0, self.length))
        return self
    }
    
    func link(_ value: String) -> Self {
        return linkURL(URL(string: value)!)
    }
    
    func linkURL(_ value: URL) -> Self {
        addAttributes([NSAttributedString.Key.link: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置字体倾斜度，取值为float，正值右倾，负值左倾
    func oblique(_ value: CGFloat = 0.1) -> Self {
        addAttributes([NSAttributedString.Key.obliqueness: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //字符间距
    func kern(_ value: CGFloat) -> Self {
        addAttributes([.kern: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置字体的横向拉伸，取值为float，正值拉伸 ，负值压缩
    func expansion(_ value: CGFloat) -> Self {
        addAttributes([.expansion: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置下划线
    func underline(_ style: NSUnderlineStyle = .single, _ color: UIColor) -> Self {
        addAttributes([
            .underlineColor: color,
            .underlineStyle: style.rawValue
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置删除线
    func strikethrough(_ style: NSUnderlineStyle = .single, _ color: UIColor) -> Self {
        addAttributes([
            .strikethroughColor: color,
            .strikethroughStyle: style.rawValue,
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置删除线
    func stroke(_ color: UIColor, _ value: CGFloat = 0) -> Self {
        addAttributes([
            .strokeColor: color,
            .strokeWidth: value,
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置基准位置 (正上负下)
    func baseline(_ value: CGFloat) -> Self {
        addAttributes([.baselineOffset: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置段落
    func paraStyle(_ alignment: NSTextAlignment,
                   lineSpacing: CGFloat = 0,
                   paragraphSpacingBefore: CGFloat = 0,
                   lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> Self {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = lineSpacing
        style.paragraphSpacingBefore = paragraphSpacingBefore
        addAttributes([.paragraphStyle: style], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置段落
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> Self {
        addAttributes([.paragraphStyle: style], range: NSMakeRange(0, self.length))
        return self
    }
}

public extension String {
    
    /// -> NSMutableAttributedString
    var matts: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
}

//@objc public extension NSAttributedString {
//    
//    /// -> NSMutableAttributedString
//    var matt: NSMutableAttributedString{
//        return NSMutableAttributedString(attributedString: self)
//    }
//    
//}
