//
//  UIControl+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/11/30.
//

import UIKit

extension UIControl {
    private struct YLControlKey {
        static let KEY_Action = UnsafeRawPointer(bitPattern: "UIControl".hashValue)!
    }
    
    func controlEvents(controlEvents: UIControl.Event, handler: @escaping YLKitButtonItemBlock) {
        let target = YLKitBlockTarget.init(block: handler);
        objc_setAssociatedObject(self, YLControlKey.KEY_Action, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.addTarget(self, action: #selector(actionFunction), for: controlEvents);
    }
    
    @objc func actionFunction() {
        let target: YLKitBlockTarget? = objc_getAssociatedObject(self, YLControlKey.KEY_Action) as? YLKitBlockTarget;
        if target?.block != nil {
            target!.block!(self);
        }
    }
}

extension UIGestureRecognizer {
    private struct YLGestureRecognizerKey {
        static let KEY_Action = UnsafeRawPointer(bitPattern: "UIGestureRecognizer".hashValue)!
    }
    
    func gestureRecognizerHandle(handler: @escaping YLKitButtonItemBlock) {
        let target = YLKitBlockTarget.init(block: handler);
        objc_setAssociatedObject(self, YLGestureRecognizerKey.KEY_Action, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.addTarget(self, action: #selector(gestureActionFunction));
    }
    
    @objc func gestureActionFunction() {
        let target: YLKitBlockTarget? = objc_getAssociatedObject(self, YLGestureRecognizerKey.KEY_Action) as? YLKitBlockTarget;
        if target?.block != nil {
            target!.block!(self);
        }
    }
}

extension UIView {
    @discardableResult
    func addTapGestureRecognizerNumberOfTap(numberOfTap: Int, handler: @escaping YLKitButtonItemBlock) -> UITapGestureRecognizer {
        
        if !self.isUserInteractionEnabled {
            self.isUserInteractionEnabled = true;
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer.init();
        tapGestureRecognizer.numberOfTapsRequired = numberOfTap;
        tapGestureRecognizer.gestureRecognizerHandle {[weak self] (_) in
            handler(self!);
        };
        self.addGestureRecognizer(tapGestureRecognizer);
        return tapGestureRecognizer;
    }
    
    @discardableResult
    func addUIControlHandler(handler: @escaping YLKitButtonItemBlock) -> UIControl {
        let control = UIControl.init();
        control.backgroundColor = UIColor.clear;
        self.insertSubview(control, at: 0);
        
        if (!self.isUserInteractionEnabled) {
            self.isUserInteractionEnabled = true;
        }
        
        control.controlEvents(controlEvents: .touchUpInside) {[weak self] (_) in
            handler(self!);
        };
        
        control.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview();
        };
        
        return control;
    }
}


