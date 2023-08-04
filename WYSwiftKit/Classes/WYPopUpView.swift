//
//  WYPopUpView.swift
//  SwiftNew
//
//  Created by apple on 2023/7/28.
//  Copyright © 2023 apple. All rights reserved.
//

import UIKit
import SnapKit

extension WYPopUpView {
    @discardableResult
    static func show(vc: UIViewController, height: CGFloat, navBar: Bool = false, bottomSafe: Bool = false, toViewController: UIViewController? = nil) -> WYPopUpView {
        let pop = WYPopUpView.init(height: height, navBar: navBar, bottomSafe: bottomSafe, toView: toViewController?.view)
        vc.view.frame = pop.contentView.bounds
        pop.contentView.addSubview(vc.view)
        pop.vc = vc
        
        if let tmpVC = toViewController {
            tmpVC.addChild(vc)
            tmpVC.view.addSubview(pop)
        } else {
            gWindow?.rootViewController?.addChild(vc)
            gWindow?.rootViewController?.view.addSubview(pop)
        }
        return pop
    }
    
    @discardableResult
    static func show(view: UIView, viewHeight: CGFloat, navBar: Bool = false, bottomSafe: Bool = false, toView: UIView? = nil) -> WYPopUpView {
        let popView = WYPopUpView.init(height: viewHeight, navBar: navBar, bottomSafe: bottomSafe, toView: toView)
        view.frame = popView.contentView.bounds
        popView.contentView.addSubview(view)
        
        if let tmpView = toView {
            tmpView.addSubview(popView)
        } else {
            // 键盘自适应失效
            gWindow?.rootViewController?.view.addSubview(popView)
        }

        return popView
    }
}

class WYPopUpView: UIView {

    //    var defaultHeight:CGFloat = 500
    var vc: UIViewController?
    //    var toSupView: UIView?
    var viewFrame: CGRect = UIScreen.main.bounds
    var contentViewHeight: CGFloat = 500
    var topHeight: CGFloat = 0
    var bottomView: UIView!
    var topIcon: UIView = UIView()
    var frameView: UIView!
    var contentView: UIView!
    var navigationBar: UINavigationBar?
    var navigationItem: UINavigationItem?
    
    var clickSpaceClose = true //点击空白处是否关闭
    var closure: (() -> ())?
    
    
    init(height: CGFloat, navBar: Bool = false, bottomSafe: Bool = false, toView: UIView?) {
        super.init(frame: UIScreen.main.bounds)
        if let tempView = toView {
            viewFrame = tempView.bounds
        }
        contentViewHeight = height
        setupUI(navBar: navBar, bottomSafe: bottomSafe)
    }
    
    convenience init(height: CGFloat, bottomSafe: Bool = false) {
        self.init(height: height, bottomSafe: bottomSafe, toView: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if clickSpaceClose {
            let touch = (touches as NSSet).anyObject() as! UITouch
            guard let result = touch.view?.isDescendant(of: frameView) else { return }
            if !result {
                dismiss()
            }
        }
    }
    
    func dismiss() {
        if let closure = closure {
            closure()
        }
        if self.vc != nil {
            self.vc?.view.removeFromSuperview()
            self.vc?.removeFromParent()
            //            self.vc = nil
        }
        self.removeFromSuperview()
    }
    
    func setupUI(navBar: Bool, bottomSafe: Bool) {
        self.frame = viewFrame
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let bottomSafeHeight = bottomSafe ? gBottomSafeHeight : 0
        let navBarHeight = navBar ? 44 : 0
        frameView = UIView()
        frameView.backgroundColor = UIColor.white
        addSubview(frameView)
        frameView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(topHeight + contentViewHeight + bottomSafeHeight)
        }
        frameView.layer.cornerRadius = 10//topHeight
        frameView.layer.masksToBounds = true
        
        if navBar {
            navigationBar = UINavigationBar()
            navigationItem = UINavigationItem()
            navigationBar?.items = [navigationItem!]
            frameView.addSubview(navigationBar!)
            navigationBar?.snp.makeConstraints { make in
                make.left.right.top.equalTo(0)
                make.height.equalTo(navBarHeight)
            }
        }
        
        
        bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        frameView.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(bottomSafeHeight)
        }
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.white
        frameView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(navBarHeight)//topHeight
            make.left.right.equalTo(0)
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
}
