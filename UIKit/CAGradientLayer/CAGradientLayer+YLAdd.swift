//
//  CAGradientLayer+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/11/30.
//

import UIKit

extension CAGradientLayer {
    class func gradientLayer(bounds: CGRect, startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer = CAGradientLayer.init();
        gradientLayer.bounds = bounds;
        
        //设置渐变色
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor];
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0);
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5);
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5);
        return gradientLayer;
    }
}
