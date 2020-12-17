//
//  DispatchQueue+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/9.
//

import Foundation

extension DispatchQueue {
    private static var _onceTracker = [String]()

    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return;
        }
        
        _onceTracker.append(token);
        block();
    }
    
    class func async_main(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block();
        } else {
            DispatchQueue.main.async(execute: {
                block();
            })
        }
    }
    
    class func async_after(_ deadline: DispatchTime, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            block();
        }
    }
    
    class func async_global(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            block();
        }
    }
}
