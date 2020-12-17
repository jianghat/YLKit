//
//  UITableView+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/29.
//

import UIKit

extension UITableView {
    private struct YLTableViewAssociateKeys {
        static var separatorZeroEnabledKey: Void?;
    }
    
    var yl_separatorZeroEnabled: Bool {
        set {
            if (newValue) {
                if YLCurrentDevice.systemVersion.floatValue() >= 7.0 {
                    if self.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                        self.separatorInset = .zero
                    }
                }
                
                if YLCurrentDevice.systemVersion.floatValue() >= 8.0 {
                    if self.responds(to:#selector(setter: UIView.layoutMargins)) {
                        self.layoutMargins = .zero
                    }
                }
            }
            objc_setAssociatedObject(self, &YLTableViewAssociateKeys.separatorZeroEnabledKey, newValue, .OBJC_ASSOCIATION_ASSIGN);
        }
        get {
            return objc_getAssociatedObject(self, &YLTableViewAssociateKeys.separatorZeroEnabledKey) as? Bool ?? false;
        }
    }
}
