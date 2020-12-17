//
//  NSNotification+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/29.
//

import Foundation

extension NotificationCenter {
    func yl_addObserver(_ observer: Any, selector: Selector, name: String, object: Any?) {
        self.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object);
    }
    
    func yl_addObserver(_ observer: Any, selector: Selector, names: [String], object: Any?) {
        for name in names {
            self.yl_addObserver(observer, selector: selector, name: name, object: object);
        }
    }
    
    func yl_post(_ name: String, object: Any?) {
        self.post(name: NSNotification.Name.init(name), object: object);
    }
}
