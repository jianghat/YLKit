//
//  UIBarButtonItem+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/10.
//

import Foundation

fileprivate struct YLBarButtonItemRuntimeKey {
    static let KEY_Action
        = UnsafeRawPointer(bitPattern: "KEY_YL_BarButtonItemKey".hashValue)!
}

extension UIBarButtonItem {
    private var blockTarget: YLKitBlockTarget? {
        get {
            return objc_getAssociatedObject(self, YLBarButtonItemRuntimeKey.KEY_Action) as? YLKitBlockTarget
        }
        set {
            objc_setAssociatedObject(self, YLBarButtonItemRuntimeKey.KEY_Action, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.target = newValue
            self.action = #selector(newValue?.invoke(_:))
        }
    }
    
    class func barButtonItem(_ title: String, actionBlock: @escaping YLKitButtonItemBlock) -> UIBarButtonItem {
        let item = UIBarButtonItem.init(title: title, style: .plain, target: nil, action: nil)
        item.setTitleTextAttributes([.foregroundColor : UIColor.white, .font: kArialFont(16)], for: .normal)
        let target = YLKitBlockTarget.init(block: actionBlock)
        item.blockTarget = target
        return item
    }
}
