//
//  NSObject+YLSwizzle.swift
//  Driver
//
//  Created by ym on 2020/10/9.
//

import Foundation

extension NSObject {
    @discardableResult
    class func swizzleInstanceMethod(originalSel: Selector, newSel: Selector) -> Bool {
        guard let originalMethod = class_getInstanceMethod(self, originalSel) else {
            return false
        }
        
        guard let swizzledMethod = class_getInstanceMethod(self, newSel) else {
            return false
        }
        
        let didAddMethod = class_addMethod(self, newSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, newSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        return true
    }
    
    @discardableResult
    class func swizzleClassMethod(originalSel: Selector, newSel: Selector) -> Bool {
        let _class: AnyClass = object_getClass(self)!
        guard let originalMethod = class_getInstanceMethod(_class, originalSel) else {
            return false
        }
        
        guard let swizzledMethod = class_getInstanceMethod(_class, newSel) else {
            return false
        }
        method_exchangeImplementations(originalMethod, swizzledMethod)
        return true
    }
}
