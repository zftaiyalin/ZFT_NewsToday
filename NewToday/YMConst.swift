//
//  YMConst.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/13.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit

/// iid 未登录用户 id，只要安装了今日头条就会生成一个 iid
/// 可以在自己的手机上安装一个今日头条，然后通过 charles 抓取一下这个 iid，
/// 替换成自己的，再进行测试
let IID: String = "5034850950"
let device_id: String = "6096495334"
let version_code = "5.7.1"
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height
/// tabBar 被点击的通知
let YMTabBarDidSelectedNotification = "YMTabBarDidSelectedNotification"
/// 动画时长
let kAnimationDuration = 0.25
/// 间距
let kMargin: CGFloat = 10.0
/// RGBA的颜色设置s
func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func YMGlobalColor() -> UIColor {
    return YMColor(r: 245, g: 245, b: 245, a: 1)
}
