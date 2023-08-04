//
//  WYBasicInfo.swift
//  SwiftNew
//
//  Created by apple on 2023/7/28.
//  Copyright © 2023 apple. All rights reserved.
//

import UIKit

public var gWindow: UIWindow? {
    guard let window = UIApplication.shared.delegate?.window else {
        return nil
    }
    return window
}

public var gRootView: UIView? {
    guard let rootView = gWindow?.rootViewController?.view else {
        return nil
    }
    return rootView
}

public var isSupportSafeArea: Bool {
    if #available(iOS 11, *) {
        return true
    }
    return false
}

// 状态栏高度
public let gStatusBarHeight: CGFloat = isSupportSafeArea ? (gWindow?.safeAreaInsets.top ?? 20) : 20

// 底部安全区高度
public let gBottomSafeHeight: CGFloat = isSupportSafeArea ? (gWindow?.safeAreaInsets.bottom ?? 0) : 0

// 导航栏高度
public let gNaviHeight: CGFloat = 44

// TableBar高度
public let gTableBarHeight: CGFloat = 49

// 顶部高度
public let gTopBarHeight: CGFloat = gStatusBarHeight + gNaviHeight

// 底部高度
public let gBottomBarHeight: CGFloat = gBottomSafeHeight + gTableBarHeight

// 屏幕高度
public let gScreenHeight = UIScreen.main.bounds.height

// 屏幕宽度
public let gScreenWidth = UIScreen.main.bounds.width

// 等比适配
public let gEqualScale = gScreenWidth / 375

// 设备udid
public let identifierNumber = UIDevice.current.identifierForVendor?.uuidString ?? ""

// Bundle Identifier
public let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? ""

// App版本号
public let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

// iOS版本
public let iOSVersion: String = UIDevice.current.systemVersion
