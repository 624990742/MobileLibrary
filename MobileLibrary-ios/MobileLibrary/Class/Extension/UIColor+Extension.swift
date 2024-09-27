//
//  UIColor+Extension.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/3/4.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//


import Foundation
import UIKit

@objc  extension UIColor {
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 ,alpha:1.0)
    }
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
         
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
         
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
         
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
         
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    ///MARK - public
    
    /**
     * 十六进制 转 RGBA
     */
    class func colorWithRGBHex(rgb:Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: alpha)
    }
    
    
    /**
     *  获取随机颜色值
     */
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
    
    /**
     *  十六进制颜色值
     *  参数为UInt类型
     *  例如 #FF4D89  只需写成 0xFF4D89
     */
     class func hexIntColor(_ val: UInt) -> UIColor {
          var r: UInt = 0, g: UInt = 0, b: UInt = 0
          var a: UInt = 0xFF
          var rgb = val
   
            if (val & 0xFFFF0000) == 0 {
                a = 0xF
                if val & 0xF000 > 0 {
                    a = val & 0xF
                    rgb = val >> 4
                }

                r = (rgb & 0xF00) >> 8
                r = (r << 4) | r

                g = (rgb & 0xF0) >> 4
                g = (g << 4) | g

                b = rgb & 0xF
                b = (b << 4) | b
                a = (a << 4) | a

            } else {
                if val & 0xFF000000 > 0 {
                    a = val & 0xFF
                    rgb = val >> 8
                }
                r = (rgb & 0xFF0000) >> 16
                g = (rgb & 0xFF00) >> 8
                b = rgb & 0xFF
            }
         return UIColor(red: CGFloat(r) / 255.0,
                           green: CGFloat(g) / 255.0,
                           blue: CGFloat(b) / 255.0,
                           alpha: CGFloat(a) / 255.0)
        }
    
    /**
     *  十六进制颜色值
     *  参数为UInt类型
     *  例如 #FF4D89  只需写成 "0xFF4D89"
     */
    class func hexStrColor(_ hex: String) -> UIColor {
        
        return UIColor.init(hexString: hex)
    }
    
    
    /**
     *  UIColor -> HexString
     *  参数为UInt类型
     *  例如 0xFF4D89  转换结果为 "#FF4D89"
     */
      var hexString: String? {
         var red: CGFloat = 0
         var green: CGFloat = 0
         var blue: CGFloat = 0
         var alpha: CGFloat = 0
         let multiplier = CGFloat(255.999999)
          
         guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
             return nil
         }
          
         if alpha == 1.0 {
             return String(
                 format: "#%02lX%02lX%02lX",
                 Int(red * multiplier),
                 Int(green * multiplier),
                 Int(blue * multiplier)
             )
         }
         else {
             return String(
                 format: "#%02lX%02lX%02lX%02lX",
                 Int(red * multiplier),
                 Int(green * multiplier),
                 Int(blue * multiplier),
                 Int(alpha * multiplier)
             )
         }
     }
}
