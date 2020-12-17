//
//  UIView+YLCornerSet.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import UIKit

enum YLBorderDirection {
    case top
    case left
    case bottom
    case right
    case all
}

extension UIView {
    class func setCornerRadius(_ target: [UIView], radius:CGFloat) {
        for item in target {
            item.layer.cornerRadius = radius
            item.layer.masksToBounds = true
        }
    }
    
    class func setCornerRadius(_ target: [UIView], radius:CGFloat, borderColor:UIColor, borderWidth:CGFloat) {
        for item in target {
            item.layer.cornerRadius = radius
            item.layer.masksToBounds = true
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
    
    func setCornerRadius(_ radius : CGFloat) {
        self.setCornerRadius(radius, borderColor: .clear)
    }
    
    func setCornerRadius(_ radius : CGFloat, borderColor: UIColor) {
        self.setCornerRadius(radius, borderColor: borderColor, borderWidth: 0)
    }
    
    func setCornerRadius(_ radius : CGFloat, borderWidth: CGFloat) {
        self.setCornerRadius(radius, borderColor: .clear, borderWidth: borderWidth)
    }
    
    func setCornerRadius(_ radius : CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radius
    }
    
    /* 部分圆角 UIView.setRoundCorners(corners: [UIRectCorner.topLeft,UIRectCorner.topRight], with: 10) */
    func setRoundCorners(_ corners:UIRectCorner, width radii: CGFloat) {
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: (self.bounds), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init();
        shape.frame = self.bounds
        shape.path = bezierpath.cgPath
        self.layer.mask = shape
    }
    
    func yl_borderLineAt(direction: YLBorderDirection, color: UIColor, width: CGFloat) {
        let splitView = UIView.init()
        splitView.backgroundColor = color
        self.addSubview(splitView)
        switch direction {
        case .top:
            splitView.snp_makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(width)
            }
        case .left:
            splitView.snp_makeConstraints { (make) in
                make.top.left.bottom.equalToSuperview()
                make.width.equalTo(width)
            }
        case .bottom:
            splitView.snp_makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(width)
            }
        case .right:
            splitView.snp_makeConstraints { (make) in
                make.right.top.bottom.equalToSuperview()
                make.width.equalTo(width)
            }
        case .all:
            self.setCornerRadius(0, borderColor: color, borderWidth: width)
        }
    }
}

