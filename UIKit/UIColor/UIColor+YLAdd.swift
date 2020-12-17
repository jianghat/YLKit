//
//  UIColor+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/25.
//  Copyright © 2020 edonesoft. All rights reserved.
//

import Foundation

func YLRGBA(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat)->UIColor { return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func YLRGBCA(_ c:CGFloat, _ a:CGFloat) -> UIColor {
    return YLRGBA(c, c, c, a)
}

func YLRGBC(_ c:CGFloat) -> UIColor {
    return YLRGBA(c, c, c, 1.0)
}

func YLRGB(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat)->UIColor {
    return YLRGBA(r, g, b, 1)
}

func YLHEXColor(_ hex: String) -> UIColor {
    return UIColor.colorWithHexString(hex)
}

extension UIColor {
    /// 生成随机色
    static var randomColor: UIColor {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        let a = CGFloat.random(in: 0...1)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    public class func colorWithHexString(_ hex:String) -> UIColor {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.length != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
