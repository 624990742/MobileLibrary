//
//  KKSwiftHeaderFile.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation
import UIKit

public enum MLBookOptionType {
    case jieYueType///借阅
    case guiHuanType///归还
    case jieYueGuanLiEditType///编辑
    case bookDetailType///书本详解界面
}

let ML_NavBackgrundColor = UIColor(red: 251.0/255.0, green: 45.0/255.0, blue: 71.0/255.0, alpha: 1.0)
/// 状态栏高度
let ML_StatusBarHeight: CGFloat = {
    var height: CGFloat = 0
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        height = windowScene.statusBarManager?.statusBarFrame.height ?? 0
    }
    return height
}()

/// 导航栏高度: 状态栏高度 + 44
let ML_NavigationHeight: CGFloat = ML_StatusBarHeight + 44
/// 屏幕的宽
let ML_ScreenWidth = UIScreen.main.bounds.width
/// 屏幕的高
let ML_ScreenHeight = UIScreen.main.bounds.height
///外边距
let ML_Margin = MLiPhoneHalf(20.0)


///主色
let ML_AppThemeColor = UIColor(hexString: "0x30b5ff")
///背景色
let ML_F7F8Color = UIColor(hexString: "0xF7F8FB")
///一级文本
let ML_OneTitleColor = UIColor(hexString: "0x26292c")
///二级文本
let ML_TwoTitleColor = UIColor(hexString: "0x5e676e")
///说明性文字
let ML_B8C2CColor = UIColor(hexString: "0xB8C2CC")
///
let ML_8A9199Color = UIColor(hexString: "0x8A9199")

// 假设这些函数已经在Swift中定义
func MLDevice_Is_iPad() -> Bool {
   // 实现判断是否是iPad的逻辑
   return UIDevice.current.userInterfaceIdiom == .pad
}

// 转换后的Swift函数
func MLiPhoneHalf(_ a: CGFloat) -> CGFloat {
  return a * ML_ScreenWidth / 375.0
}


///------热门搜索-------///
//标题高度
let MLSearch_tagTitleHeighT = 20.0
//清除tip文本
let MLSearch_deleteTip = "您要清除搜索记录么？"
//key
let MLSearch_kHistroySearchData = "HistroySearchData"
//最大历史搜索条数
let MLSearch_kMaxHistroyNum = 10
