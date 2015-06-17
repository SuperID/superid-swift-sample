//
//  MacroDefinition.swift
//  SuperID_SwiftDemo
//
//  Created by YourtionGuo on 2/3/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

import Foundation

func HEXRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//读取沙盒图片
func SANDBOXIMAGE(filename: String) -> UIImage {
    return UIImage(contentsOfFile: NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(filename))!
}

//读取沙盒图片地址
func SANDBOXIMAGEPATH(filename: String) -> String {
    return NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent(filename)
}

func VIEW_W(view: UIView) -> CGFloat{
    return view.frame.size.width
}

//Screen Height and width
let SCREEN_HEIGHT  = UIScreen.mainScreen().bounds.size.height
let SCREEN_WIDTH  = UIScreen.mainScreen().bounds.size.width

let IS_IPHONE4 = UIScreen.mainScreen().bounds.size.height < 500
let IS_IOS7 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0