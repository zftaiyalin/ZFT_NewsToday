//
//  YMConst.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/13.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height
/// tabBar 被点击的通知
let YMTabBarDidSelectedNotification = "YMTabBarDidSelectedNotification"
/// 动画时长
let kAnimationDuration = 0.25

/// RGBA的颜色设置s
func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func YMGlobalColor() -> UIColor {
    return YMColor(245, g: 245, b: 245, a: 1)
}
