//
//  YLGradient.swift
//  Driver
//
//  Created by ym on 2020/10/8.
//

import UIKit

enum YLGradientType {
    case TopToBottom //从上到小
    case LeftToRight //从左到右
    case UpleftToLowright //左上到右下
    case UprightToLowleft //右上到左下
}

extension UIImage {
    class func gradientImageFromColors(colors: [UIColor], imgSize: CGSize, gradientType: YLGradientType) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imgSize, true, 1)
        guard let context = UIGraphicsGetCurrentContext () else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.saveGState()
        let array: [CGColor] = colors.map { (color: UIColor) -> CGColor in
            return color.cgColor
        }
        let colorSpace = array.last?.colorSpace ?? CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors:array as CFArray,
                                        locations: nil) else { return nil }
        var start: CGPoint
        var end: CGPoint
        switch (gradientType) {
        case .TopToBottom:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: 0.0, y: imgSize.height)
        case .LeftToRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: imgSize.width, y: 0.0)
        case .UpleftToLowright:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: imgSize.width, y: imgSize.height)
        case .UprightToLowleft:
            start = CGPoint(x: imgSize.width, y: 0.0)
            end = CGPoint(x: 0.0, y: imgSize.height)
        }
        context.drawLinearGradient(gradient, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context.restoreGState()
        UIGraphicsEndImageContext()
        return image
    }
}
