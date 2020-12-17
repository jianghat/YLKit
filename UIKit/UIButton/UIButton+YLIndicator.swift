//
//  UIButton+YLIndicator.swift
//  Driver
//
//  Created by ym on 2020/10/12.
//

import Foundation

extension UIButton {
    fileprivate struct YLUIButtonRuntimeKey {
        static let textObject = UnsafeRawPointer(bitPattern: "buttonTextObject".hashValue)!
        static let indicator = UnsafeRawPointer(bitPattern: "indicatorObject".hashValue)!
    }
    /*
     *  @brief  显示加载等待框
     */
    func showIndicator() {
        let indicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        indicator.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        indicator.startAnimating()
        
        let oldTitle = self.titleLabel?.text ?? ""
        
        objc_setAssociatedObject(self, YLUIButtonRuntimeKey.textObject, oldTitle, .OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(self, YLUIButtonRuntimeKey.indicator, indicator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        self.setTitle("", for: UIControl.State.normal)
        self.isEnabled = false;
        self.addSubview(indicator)
    }
    
    /*
     *  @brief  移除加载等待框
     */
    func hideIndicator() {
        let indicator = objc_getAssociatedObject(self, YLUIButtonRuntimeKey.indicator) as? UIActivityIndicatorView
        indicator?.removeFromSuperview()
        let oldTitle = objc_getAssociatedObject(self, YLUIButtonRuntimeKey.textObject) as? String
        self.setTitle(oldTitle, for: UIControl.State.normal)
        self.isEnabled = true
    }
}

