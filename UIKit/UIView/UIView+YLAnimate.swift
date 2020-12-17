//
//  UIView+YLAnimate.swift
//  Driver
//
//  Created by ym on 2020/10/12./
//

import Foundation

extension UIView {
    class func YL_Animate(view: UIView, duration: TimeInterval, animation: @escaping () -> Void) {
        view.superview?.layoutIfNeeded()
        UIView.animate(withDuration: duration) {
            animation()
            view.superview?.layoutIfNeeded()
        }
    }
    
    class func YL_Animate(view: UIView, duration: TimeInterval, animation: @escaping () -> Void?, completion: @escaping () -> Void?) {
        view.superview?.layoutIfNeeded()
        UIView.animate(withDuration: duration) {
            animation()
            view.superview?.layoutIfNeeded()
        } completion: { (rs) in
            completion()
        }
    }
    
    class func YL_ScaleAnimate(view: UIView, duration: TimeInterval, repeatCount: Float, fromValue: Float, toValue: Float, animation: @escaping () -> Void?, completion: @escaping () -> Void?) {
        view.superview?.layoutIfNeeded()
        // 设定为缩放
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale");
        animation.delegate = view;
        // 动画选项设定
        animation.duration = duration; // 动画持续时间
        animation.repeatCount = repeatCount; // 重复次数(无限)
        animation.autoreverses = true; // 动画结束时执行逆动画

        // 缩放倍数
        animation.fromValue = fromValue; // 开始时的倍率
        animation.toValue = toValue; // 结束时的倍率

        // 添加动画
        view.layer.add(animation, forKey: "scale-layer");
    }
}

extension UIView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(anim.className());
    }
}
